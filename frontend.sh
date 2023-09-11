source common.sh

echo installing the nginx
dnf install nginx -y >>$log_file

echo placing the expense config file
cp expense.conf  /etc/nginx/default.d/expense.conf >>$log_file

systemctl enable nginx >>/tmp/expense.log
systemctl start nginx >>/tmp/expense.log

echo removing the old content
rm -rf /usr/share/nginx/html/* >>$log_file

echo download the frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html >>$log_file

echo extracting the file
unzip /tmp/frontend.zip >>$log_file

echo restarting the file
systemctl restart nginx >>$log_file

