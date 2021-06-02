#####TASK 1#######
Created a IAM role Called Sasmita_CourseAssignment with full S3 access. 
Created a Security group called SG_Sasmita which opens HTTP, HTTPS, SSH. 
Created a EC2 instance which is an Ubuntu OS, Assigned the the IAM role and assigned the security group. 
Created a S3 bucket named upgrad_sasmita.
########TASK 2########
We need to write a scrip which will do the following task. 
It will update the packge.
It checkes if apache2 is installed or not.
If not it installs the apache2.
It checkes for apache2 status. 
it restarts apache2 whenever the system reboots. 
We need to write code so that the access and error log files present in /var/www/apache should be transfered to AWS s3 bucket. 
Need to install aws cli manually or through script. 
We have used myname and timestamp variable and first we have converted the access and error log files into tar file. then we need to copy it to the /tmp folder and then we need to send it to the S3 bucket. in this place we need AWS cli installed and the IAM role comes into picture. 
##########TASK 3########################
We have kept a track of the tar file which is getting transfered in the /var/www/html location. 
We have scheduled a cron job which will run every single day and it should always apend the a new line and not over write. 
