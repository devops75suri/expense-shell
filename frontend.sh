echo installing the nginx
dnf install nginx -y >/tmp//expense.log

echo placling expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf >/tmp//expense.log

echo removeing old content
rm -rf /usr/share/nginx/html/* >/tmp//expense.log

echo download the frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >/tmp//expense.log

cd /usr/share/nginx/html >/tmp//expense.log

echo extracting the forntend code
unzip /tmp/frontend.zip >/tmp//expense.log

echo starting the nginx service
systemctl enable nginx >/tmp//expense.log
systemctl restart nginx >/tmp//expense.log