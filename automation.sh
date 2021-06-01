#This is for Dev branch for Pull request Purpose which will be Merged with main branch"
#Update package#
sudo apt update -y
#Check If Apache2 is installed or not#
dpkg --get-selections | grep apache2
#Install Pacage apache2#
sudo apt install apache2
#Check for apache2 status#
service apache2 status
#Restart apache2 Service#
sudo systemctl start apache2
#Code for transfering the tar log file to S3#
cd /var/log/
myname='sasmita'
timestamp=$(date '+%d%m%Y-%H%M%S')
sudo tar -cvf ${myname}-httpd-logs-${timestamp}.tar apache2 
cp /var/log/${myname}-httpd-logs-${timestamp}.tar /tmp 
s3_bucket=upgrad-sasmita
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
#Creating Inventory.html iand apend all the data every time#
#cd /var/log
size=$(du -h "${myname}-httpd-logs-${timestamp}.tar" | cut -f1)
FILE=/var/www/html/inventory.html
if [ -f "$FILE" ]; then
    echo "$FILE exists."
   # myfilesize=$(stat --format=%s "/var/www/html/inventory.html")
   # myfilesize=$(find "$size" -printf "%s")
    cd /var/www/html
    value=$(<inventory.html)
    sudo echo  "$value<p>-httpd-log&emsp;&emsp;&emsp;$timestamp&emsp;&emsp;&emsp;tar&emsp;&emsp;&emsp;$size</p>"  > /var/www/html/inventory.html
    
else 
    echo "$FILE is getting created."
    cd /var/www/html
    sudo touch /var/www/html/inventory.html
    sudo echo "<h3>Log Type&emsp;&emsp;Time Created&emsp;&emsp;Type&emsp;&emsp;Size</h3>"  > /var/www/html/inventory.html
   
fi
#Submit Cron job#
FILE1=/etc/cron.d/automation1
if [ -f "$FILE1" ]; then
	echo "Cron job is already scheduled for tomorrow"
else
	
	echo "Scheduling a cron job"
	cd /etc/cron.d/
	sudo touch /etc/cron.d/automation1
	sudo echo "0 14 * * * /root  /root/Automation_Project/automation.sh" > /etc/cron.d/automation1
fi
	
