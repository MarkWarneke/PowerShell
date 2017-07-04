# This script creates a new Hyper-V machine with hard drive, memory & network resources configured.

# Variables
$SRV1 = Read-Host "Enter the Virtual Machine name (Press [Enter] to choose Server01): "
if ($SRV1 -eq ""){$SRV1="Server01"} ; if ($SRV1 -eq $NULL){$SRV1="Server01"}

$SRAM = Read-Host "Enter the size of the Virtual Machine Memory (Press [Enter] to choose 512MB): "
if ($SRAM -eq ""){$SRAM=512MB} ; if ($SRAM -eq $NULL){$SRAM=512MB}

$SRV1VHD = Read-Host "Enter the size of the Virtual Machine Hard Drive (Press [Enter] to choose 40GB): "
if ($SRV1VHD -eq ""){$SRV1VHD=40GB} ; if ($SRV1VHD -eq $NULL){$SRV1VHD=40GB}

$VMLOC = Read-Host "Enter the location of the Virtual Machine file (Press [Enter] to choose C:\HyperV): "
if ($VMLOC -eq ""){$VMLOC="C:\HyperV"} ; if ($VMLOC -eq $NULL){$VMLOC="C:\HyperV"}

$Network1 = Read-Host "Enter the name of the Virtual Machine Network (Press [Enter] to choose Network1): "
if ($Network1 -eq ""){$Network1="Network1"} ; if ($Network1 -eq $NULL){$Network1="Network1"}

# Configure Hyper-V Virtual Network
remove-vmswitch $Network1 -force -erroractionsilentlycontinue
new-vmprivateswitch $Network1

# Create Virtual Machines
MD $VMLoc -erroractionsilentlycontinue
new-vm $SRV1 -path $VMLoc
new-vhd -vhdpaths $VMLoc\$SRV1 -size $SRV1VHD
add-vmdisk -vm $SRV1 -controllerid 0 -lun 0 -path $VMLoc\$SRV1
get-vm $SRV1 | add-vmdrive -controllerid 1 -lun 0 -dvd
get-vm $SRV1 | set-vmmemory -memory $SRAM
get-vm $SRV1 | add-vmnic -virtualswitch $Network1