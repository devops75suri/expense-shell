dnf module disable mysql -y

dnf install mysql-community-server -y

cp mysql.repo /etc/yum.repos.d/mysql.repo

systemctl enable mysqld

systemctl start mysqld

mysql_secure_installation --set-root-pass ExpenseApp@1

