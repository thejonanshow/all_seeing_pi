#!/bin/bash

DATE=$(date +%Y-%m-%d_%H-%M-%S-%N)

raspistill -vf -hf -t 0 -o $DATE.jpg
echo $DATE.jpg
