echo installing the nginx
dnf install nginx -y >/tmp/expense.log

echo placing the expense config file
cp expense.conf  /etc/nginx/default.d/expense.conf >/tmp/expense.log

systemctl enable nginx >/tmp/expense.log
systemctl start nginx >/tmp/expense.log

echo removing the old content
rm -rf /usr/share/nginx/html/* >/tmp/expense.log

echo download the frontend code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >/tmp/expense.log

cd /usr/share/nginx/html >/tmp/expense.log

echo extracting the file
unzip /tmp/frontend.zip >/tmp/expense.log

echo restarting the file
systemctl restart nginx >/tmp/expense.log

