Please find the below details to run the infra:

1. you need to have existing azure subscription 
2. If you want to maintain azure state file in storage, you should required existing storage. backendstatefile.tf in this file you can see the details. if you dont want state file, you can delete this file. So you dont need any storage account.  
3. Create the AAD group to assgin the role assignments, pass the AAD group object id whereever required in the terraform code
4. Change the subscription id(subscription_id) in the tfvars file.
5. Run the terraform script, it will provision the resources
