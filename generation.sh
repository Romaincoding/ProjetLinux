#!/bin/bash

timer=$1

./genTick $timer | ./genSensorData 
