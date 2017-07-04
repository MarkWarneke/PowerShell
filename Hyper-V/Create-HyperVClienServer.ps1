# This script configures the Hyper-V machines used for the 50331 Course.
# PowerShell 3.0 and Windows Server 2012 or Windows 8 Pro are required to perform this setup.
# The C:\ Drive should have at least 200GB of free space available.
# All the files on the 50331 Student CD should be copied to C:\Labfiles before performing this setup.

# Variables
$CLI1 = "50331-CUSTOM-CLI"		# Name of VM running Client Operating System
$SRV1 = "50331-CUSTOM-SRV"		# Name of VM running Server Operating System
$CRAM = 2GB				                # RAM assigned to Client Operating System
$SRAM = 1GB				                # RAM assigned to Server Operating System
$CLI1VHD = 80GB				                # Size of Hard-Drive for Client Operating System
$SRV1VHD = 40GB				                # Size of Hard-Drive for Server Operating System
$VMLOC = "C:\HyperV"			        # Location of the VM and VHDX files
$NetworkSwitch1 = "PrivateSwitch1"	# Name of the Network Switch
$W7ISO = "C:\Labfiles\Windows7.iso"	# Windows 7 ISO
$W7VFD = "C:\Labfiles\Windows7.vfd"	# Windows 7 Virtual Floppy Disk with autounattend.xml file
$WSISO = "C:\Labfiles\W2K8R2.iso"	        # Windows Server 2008 ISO
$WSVFD = "C:\Labfiles\W2K8R2.vfd"	# Windows Server 2008 Virtual Floppy Disk with autounattend.xml file

# Create VM Folder and Network Switch
MD $VMLOC -ErrorAction SilentlyContinue
$TestSwitch = Get-VMSwitch -Name $NetworkSwitch1 -ErrorAction SilentlyContinue; if ($TestSwitch.Count -EQ 0){New-VMSwitch -Name $NetworkSwitch1 -SwitchType Private}

# Create Virtual Machines
New-VM -Name $CLI1 -Path $VMLOC -MemoryStartupBytes $CRAM -NewVHDPath $VMLOC\$CLI1.vhdx -NewVHDSizeBytes $CLI1VHD -SwitchName $NetworkSwitch1
New-VM -Name $SRV1 -Path $VMLOC -MemoryStartupBytes $SRAM -NewVHDPath $VMLOC\$SRV1.vhdx -NewVHDSizeBytes $SRV1VHD -SwitchName $NetworkSwitch1

# Configure Virtual Machines
Set-VMDvdDrive -VMName $CLI1 -Path $W7ISO
Set-VMDvdDrive -VMName $SRV1 -Path $WSISO
Set-VMFloppyDiskDrive -VMName $CLI1 -Path $W7VFD
Set-VMFloppyDiskDrive -VMName $SRV1 -Path $WSVFD
Start-VM $SRV1
Start-VM $CLI1