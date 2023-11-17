#!/bin/bash

# Get the VM's name and start it
VM_NAME=$1
VM_IP=$2
VBoxManage startvm "$VM_NAME" --type headless

# Wait the VM to booted up
echo "Wait till the VM booted successfully"
sleep 30

# Try connecting SSH
echo "Connecting to the VM via SSH"
while true
do
    ssh root@$VM_IP
    sleep 3
done
