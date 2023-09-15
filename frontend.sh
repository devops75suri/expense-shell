source common.sh
component=frontend  # is a local variable

echo installing the nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo placling expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

echo removeing old content
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi

cd /usr/share/nginx/html &>>$log_file

download_and_extract

echo starting the nginx service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCESS\e[0m"
else
  echo -e "\e[31mfailed\e[0m"
fi
