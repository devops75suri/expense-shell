source common.sh

echo disable mysql 8 version
dnf module disable mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo copy my sql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo my sql server
dnf install mysql-community-server -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo start my service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi
