source common.sh
component=frontend  # is a local variable

echo installing the nginx
dnf install nginx -y &>>$log_file
stat_check

echo placling expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check

echo removeing old content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check

cd /usr/share/nginx/html &>>$log_file

download_and_extract

echo starting the nginx service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
stat_check
