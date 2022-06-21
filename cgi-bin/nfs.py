from subprocess import call

call(["systemctl", "status", "nfs-kernel-server"])
