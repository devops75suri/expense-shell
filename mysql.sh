source common.sh

echo disable mysql 8 version
dnf module disable mysql -y &>>$log_file
stat_check

echo copy my sql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo my sql server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo start my service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
stat_check
