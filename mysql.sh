source common.sh
echo disableing the mysql
dnf module disable mysql -y >>log_file

echo moving the mysql repo file
cp mysql.repo  /etc/yum.repos.d/mysql.repo >>log_file

echo installing mysql file
dnf install mysql-community-server -y >>log_file

echo start mysql services
systemctl enable mysqld >>log_file
systemctl start mysqld >>log_file

echi to setup root user
mysql_secure_installation --set-root-pass ExpenseApp@1 >>log_file

