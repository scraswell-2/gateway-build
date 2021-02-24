#!/bin/bash
#######################################################
## NETWORK ENVIRONMENT VARIABLES
#######################################################
BRIDGE_NAME=br0

VM_NAME=

PIDFILE=/run/${VM_NAME}.pid
TAP_DEV=tap0

PIPE_BASE=/var/run/qemu-${VM_NAME}
PIPE_IN=${PIPE_BASE}.in
PIPE_OUT=${PIPE_BASE}.out

#######################################################
## START-BACKUP_VM SCRIPT
#######################################################
start() {
    echo "[VM] Starting backup virtual machine..."

    mkfifo ${PIPE_IN} ${PIPE_OUT} && \
        qemu-system-x86_64 \
            -daemonize \
            -pidfile ${PIDFILE} \
            -vnc 0.0.0.0:0,password \
            -enable-kvm \
            -machine type=q35,accel=kvm \
            -cpu host \
            -smp 2 \
            -m 3G \
            -object iothread,id=iothread1 \
            -device virtio-scsi-pci,id=scsi0,iothread=iothread1 \
            -drive file=/dev/disk/by-id/ata-KINGSTON_SNV425S264GB_07TA50000160,if=none,format=raw,discard=unmap,aio=native,cache=none,id=scsi0 \
            -device scsi-hd,drive=scsi0,bus=scsi0.0 \
            -object iothread,id=iothread2 \
            -device virtio-scsi-pci,id=scsi1,iothread=iothread2 \
            -drive file=/dev/disk/by-id/usb-WD_My_Book_25EE_5758313144323941304A3331-0:0,if=none,format=raw,discard=unmap,aio=native,cache=none,id=scsi1 \
            -device scsi-hd,drive=scsi1,bus=scsi1.0 \
            -device virtio-net,netdev=network0,mac=01:01:01:00:00:3e \
            -netdev tap,id=network0,ifname=${TAP_DEV},script=no,downscript=no,vhost=on \
            -device nec-usb-xhci,id=xhci \
            -device usb-tablet,bus=xhci.0 \
            -vga std \
            -monitor pipe:${PIPE_BASE} && \
    /usr/local/share/connect-vm ${TAP_DEV} ${BRIDGE_NAME}

    echo "[VM] Backup virtual machine PID == $(cat ${PIDFILE})"
    echo "change vnc password password" > ${PIPE_IN}
}

#######################################################
## STOP-BACKUP_VM SCRIPT
#######################################################
stop() {
    echo "[VM] Stopping backup virtual machine..."
    echo "system_powerdown" > ${PIPE_IN}

    echo -n "[VM] waiting for stop"
    while [ -f "${PIDFILE}" ]
    do
        echo -n "."
        sleep 1s
    done

    echo ""
    echo "[VM] stopped."
    rm -v ${PIPE_IN} ${PIPE_OUT}
}

case ${1} in
  start|stop) "${1}" ;;
  *) echo -e "\nUsage ${0} (start|stop)\n\n" ;;
esac