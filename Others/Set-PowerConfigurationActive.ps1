#| = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = |   
#|{>/-------------------------------------------------------------\<}|             
#|: | Author:  Aman Dhally                                         
#| :| Email:   amandhally@gmail.com                  
#|: | Purpose:                                                           
#| :|            Check the PowerScheme on the Laptop and Assign the Desired One  
#|: |                                                              
#|: |                                Date: 09-11-2011              
#| :|     /^(o.o)^\     
#|{>\-------------------------------------------------------------/<}| 
#| = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = : = | 
#+-------------------------------------------------------------------+#  
# Powercfg - L # to get the Available list of all Power Settings  schemes 
# powercfg  -L# 
# 
#Existing Power Schemes (* Active) 
#----------------------------------- 
#Power Scheme GUID: 1ca6081e-7f76-46f8-b8e5-92a6bd9800cd  (Maximum Battery 
#Power Scheme GUID: 2ae0e187-676e-4db0-a121-3b7ddeb3c420  (Power Source Opt 
#Power Scheme GUID: 37aa8291-02f6-4f6c-a377-6047bba97761  (Timers off (Pres 
#Power Scheme GUID: 381b4222-f694-41f0-9685-ff5bb260df2e  (Balanced) 
#Power Scheme GUID: 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c  (High performance 
#Power Scheme GUID: a1841308-3541-4fab-bc81-f71556f20b4a  (Power saver) 
#Power Scheme GUID: a666c91e-9613-4d84-a48e-2e4b7a016431  (Maximum Performa 
#Power Scheme GUID: de7ef2ae-119c-458b-a5a3-997c2221e76e  (Energy Star) 
#Power Scheme GUID: e11a5899-9d8e-4ded-8740-628976fc3e63  (Video Playback) 
# 
# 
# 
 
##### Variables  # # #  # # # 
 
 
## I want to Use Energy Start as Deault PowerScheme on All Laptops # 
 
$x = 'de7ef2ae-119c-458b-a5a3-997c2221e76e'   
 
# Lets Check what is our Current Active "Power Scheme" and put it on a Variable 
 
$currScheme = POWERCFG -GETACTIVESCHEME  
 
# Put $CurrScheme in a variable and Spilt is so that we can get the GUID of Active "Power Scheme" 
 
$y = $currScheme.Split() 
 
############################# 
### Script Starts Here ###### 
############################# 
 
 # $y[3] is GUID of Active "Power Scheme" 
if ($y[3] -eq $x) { 
 
    write-Host -ForegroundColor yellow "You Have correct Settings, Nothing to Do!!! " 
     
    } else { 
     
            Write-Warning "You Have Wrong Power Scheme Set, let me fix it for you"  
             
            PowerCfg -SetActive $x 
             
            write-Host -ForegroundColor Green "PowerScheme Sucessfully Applied" 
             
            } 
             
             
##### End of Script # # # # 
#### Its Tested on Windows 7 Only ##########