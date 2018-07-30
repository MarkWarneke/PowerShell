## Run Model Training
Start-Job -Name Subcat1 -ScriptBlock {
### Train Subcat external
az ml experiment submit -c dbottomldsvm -p "C:\Users\$env:username\Documents\AzureML\tbottomlproject\" --wait code\2train_subcat.py --task 1
}
Start-Job -Name Subcat2 -ScriptBlock {
### Train Subcat internal
az ml experiment submit -c dbottomldsvm -p "C:\Users\$env:username\Documents\AzureML\tbottomlproject\" --wait code\2train_subcat.py --task 2
}
Start-Job -Name Prio -ScriptBlock {
### Train Priority
az ml experiment submit -c dbottomldsvm -p "C:\Users\$env:username\Documents\AzureML\tbottomlproject\" --wait code\2train_priority.py
}
 
#Wait for all jobs
Get-Job | Wait-Job
#Get all job results
Get-Job | Receive-Job | Out-GridView