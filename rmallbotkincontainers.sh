#!/bin/bash
sudo docker ps -a | grep "botkin" | awk '{print $1}' | xargs sudo docker rm

