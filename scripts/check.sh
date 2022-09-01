#!/bin/bash

while ! docker logs wireguard | grep -q "[services.d] done.";
do
    sleep 1
    echo "working..."
done