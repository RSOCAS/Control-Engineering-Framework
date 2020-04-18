# -*- coding: utf-8 -*-
#
#     ||          ____  _ __
#  +------+      / __ )(_) /_______________ _____  ___
#  | 0xBC |     / __  / / __/ ___/ ___/ __ `/_  / / _ \
#  +------+    / /_/ / / /_/ /__/ /  / /_/ / / /_/  __/
#   ||  ||    /_____/_/\__/\___/_/   \__,_/ /___/\___/
#
#  Copyright (C) 2016 Bitcraze AB
#
#  Crazyflie Nano Quadcopter Client
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA  02110-1301, USA.
"""
Simple example that connects to the crazyflie at `URI` and runs a figure 8
sequence. This script requires some kind of location system, it has been
tested with (and designed for) the flow deck.

Change the URI variable to your Crazyflie configuration.
"""
import logging
import time
import math
import os
from tkinter import*

import cflib.crtp
from cflib.crazyflie.log import LogConfig
from cflib.crazyflie.syncCrazyflie import SyncCrazyflie
from cflib.crazyflie.syncLogger import SyncLogger


URI = 'radio://0/80/2M'

# Only output errors from the logging framework
logging.basicConfig(level=logging.ERROR)

def position_callback(timestamp, data, logconf):
    global altitud
    altitude = data['stateEstimate.z']

def position_callback2(timestamp, data, logconf):
    global roll
    global pitch
    global yaw
    roll = data['stabilizer.roll']
    pitch = -data['stabilizer.pitch'] #Cambio de signo para coherencia con el criterio
    yaw = data['stabilizer.yaw']

def position_callback3(timestamp, data, logconf):
    global pitch_Rate
    global roll_Rate
    global yaw_Rate
    pitch_Rate = data['gyro.y']
    roll_Rate = data['gyro.x']
    yaw_Rate = data['gyro.z']

def position_callback4(timestamp, data, logconf):
    global m1
    global m2
    global m3
    global m4
    #print('[%d][%s]: %s' % (timestamp, logconf.name, data))
    m1 = data['motor.m1']
    m2 = data['motor.m2']
    m3 = data['motor.m3']
    m4 = data['motor.m4']
    

def start_position_printing(scf):
    log_conf = LogConfig(name='Baro', period_in_ms=10)
    log_conf.add_variable('stateEstimate.z', 'float')
    scf.cf.log.add_config(log_conf)
    log_conf.data_received_cb.add_callback(position_callback)
    log_conf.start()

def start_position_printing2(scf):
    log_conf2 = LogConfig(name='Stabilizer', period_in_ms=10)
    log_conf2.add_variable('stabilizer.roll', 'float')
    log_conf2.add_variable('stabilizer.pitch', 'float')
    log_conf2.add_variable('stabilizer.yaw', 'float')
    scf.cf.log.add_config(log_conf2)
    log_conf2.data_received_cb.add_callback(position_callback2)
    log_conf2.start()

def start_position_printing3(scf):
    log_conf3 = LogConfig(name='Gyro', period_in_ms=10)
    log_conf3.add_variable('gyro.x', 'float')
    log_conf3.add_variable('gyro.y', 'float')
    log_conf3.add_variable('gyro.z', 'float')
    scf.cf.log.add_config(log_conf3)
    log_conf3.data_received_cb.add_callback(position_callback3)
    log_conf3.start()

def start_position_printing4(scf):
    log_conf4 = LogConfig(name='Motor', period_in_ms=10)
    log_conf4.add_variable('motor.m1', 'float')
    log_conf4.add_variable('motor.m2', 'float')
    log_conf4.add_variable('motor.m3', 'float')
    log_conf4.add_variable('motor.m4', 'float')
    scf.cf.log.add_config(log_conf4)
    log_conf4.data_received_cb.add_callback(position_callback4)
    log_conf4.start()




if __name__ == '__main__':
   
    #Sensor variables
    altitude=0
    roll=0
    pitch=0
    yaw=0
    roll_Rate=0
    pitch_Rate=0
    yaw_Rate=0
    m1=0
    m2=0
    m3=0
    m4=0

    #Controller variables (the variables "Kp", "Ki" and "Kd" have to be set with the values of desiging controller)
    e=0
    e_ant=0
    Kp=0
    Ki=0
    Kd=0
    integral=0
    derivative=0
    dt=0.01
    Event_th=0

    # Refernece Signals (the variables "reference_altitude" and "reference_yaw" have to be set with the values of the reference signals)
    reference_altitude=0
    reference_yaw=0
    

    # Initialize the low-level drivers (don't list the debug drivers)
    cflib.crtp.init_drivers(enable_debug_driver=False)

    with SyncCrazyflie(URI) as scf:
        cf = scf.cf

        cf.param.set_value('kalman.resetEstimation', '1')
        time.sleep(0.1)
        cf.param.set_value('kalman.resetEstimation', '0')
        time.sleep(2)

        start_position_printing(scf)
        start_position_printing2(scf)
        start_position_printing3(scf)
        start_position_printing4(scf)
	
	# Uncomment the option that you want to implement. The code is defined with the variables "altitude" and "reference_altitude" but they can be change by the "yaw" and "reference_yaw".
        # On the other hand, with the command "cf.commander.send_setpoint(roll, pitch, yawrate, thrust)" the variable "thrust" is used for the altitude controller and the "yawrate" for the 
        # directional controller.
        
	# OPTION 1: PERIODIC PID
        #for _ in range(1500):				#In this example the loop lasts 15 seconds
	#   e=refence_altitude-altitude 		#Error signal
	#   integral=integral+e*dt			#Integral term
	#   derivative=(e-e_ant)/dt			#Derivative term
	#   thrust=Kp*e+Ki*integral+Kd*derivative	#Kp, Ki and Kd are the controller's gains
	#   e_ant=e
	#   cf.commander.send_setpoint(0,0,0,thrust)	#Sending the control signal to the drone
	#   time.sleep(0.01)

	# OPTION 2: EVENT-BASED PID
	#for _ in range(1500):					#In this example the loop lasts 15 seconds
	#   e=refence_altitude-altitude 			#Error signal
        #   if(abs(e)>Event_Th):				#Event detector
	#   	integral=integral+e*dt				#Integral term
	#   	derivative=(e-e_ant)/dt				#Derivative term
	#   	thrust=Kp*e+Ki*integral+Kd*derivative		#Kp, Ki and Kd are the controller's gains
	#   	e_ant=e
	#   	cf.commander.send_setpoint(0,0,0,thrust)	#Sending the control signal to the drone
	#   	time.sleep(0.01)
        
            

        
