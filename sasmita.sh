#This is a test#
#this is for Dev Branch#
#This is my scripting Details#
sudo apt update -y
dpkg --get-selections | grep apache
sudo apt install apache2
service apache2 status
sudo systemctl start apache2
cd /var/log/
myname='sasmita'
timestamp=$(date '+%d%m%Y-%H%M%S')
sudo tar -cvf ${myname}-httpd-logs-${timestamp}.tar apache2
cp /var/log/${myname}-httpd-logs-${timestamp}.tar /tmp
s3_bucket=upgrad-sasmita
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar

