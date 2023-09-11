source common.sh
component=frontend

echo installing the nginx
dnf install nginx -y &>>$log_file
if [ $? = 0 ]; then
  echo sucess
else
  echo failed
fi

echo placing the expense config file
cp expense.conf  /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? = 0 ]; then
  echo sucess
else
  echo failed
fi

systemctl enable nginx >>/tmp/expense.log
systemctl start nginx >>/tmp/expense.log

echo removing the old content
rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? = 0 ]; then
  echo sucess
else
  echo failed
fi

cd /usr/share/nginx/html &>>$log_file

download_and_extract

echo restarting the file
systemctl restart nginx &>>$log_file
if [ $? = 0 ]; then
  echo sucess
else
  echo failed
fi

