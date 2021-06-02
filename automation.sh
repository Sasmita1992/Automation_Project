#This is for Dev branch for Pull request Purpose which will be Merged with main branch #########
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
sudo tar -cvf ${myname}-httpd-logs-${timestamp}.tar --exclude=other_vhosts_access.log  apache2/*.log 
cp /var/log/${myname}-httpd-logs-${timestamp}.tar /tmp 
s3_bucket=upgrad-sasmita
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
#Creating Inventory.html iand apend all the data every time#
size=$( (du -h /tmp/${myname}-httpd-logs-${timestamp}.tar | cut -f1) )
FILE='/var/www/html/inventory.html'
if [ ! -e $FILE ]; then
   
   sudo touch /var/www/html/inventory.html

   sudo echo "<h3>Log Type&emsp;&emsp;Time Created&emsp;&emsp;Type&emsp;&emsp;Size</h3>"  > /var/www/html/inventory.html
 
   sudo echo  "$value<p>-httpd-log&emsp;&emsp;&emsp;$timestamp&emsp;&emsp;&emsp;tar&emsp;&emsp;&emsp;$size</p>" >> /var/www/html/inventory.html
   cd /root/Automation_Project 
else 
    sudo echo "<p>-httpd-log&emsp;&emsp;&emsp;$timestamp&emsp;&emsp;&emsp;tar&emsp;&emsp;&emsp;$size</p>"  >> /var/www/html/inventory.html
fi
#Submit Cron job#
FILE1=/etc/cron.d/automation
if [ ! -e $FILE1 ]; then

        cd /etc/cron.d/
	sudo touch /etc/cron.d/automation
	sudo echo "* * * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
fi
