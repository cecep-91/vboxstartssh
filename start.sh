#!/bin/bash

wait_boot() {
    if [ $? -eq 0 ]
    then
        echo "Wait till the VM booted successfully"
        sleep 30
    fi
}

dossh() {
    echo "Connecting to the VM via SSH"
    while true
    do
        ssh ${UNAME}@${VM_IP}
        sleep 3
        if [ $? -eq 0 ]
        then
            exit 0
        fi
    done
}

# Get the variable needed
SCRIPT_NAME=$(basename "$0")
# Check syntax, set UNAME as root if not declared
    if [ $# -lt 2 ] || [ $# -gt 3 ]; then
        echo "usage: $SCRIPT_NAME <vm_name> <vm_ip> <username to ssh (optional)>"
        exit 1
    elif [ $# -eq 2 ]; then
        UNAME="root"   
    elif [ $# -eq 3 ]; then
        UNAME="$3"
    fi
VM_NAME=$1
VM_IP=$2

# Start VM in background
VBoxManage startvm "$VM_NAME" --type headless

# Wait the VM to booted up
wait_boot

# Try connecting SSH
dossh
