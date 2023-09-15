log_file=/tmp/expense.log

echo installing the nginx
dnf install nginx -y >>log_file

echo placling expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>log_file

echo removeing old content
rm -rf /usr/share/nginx/html/* >>log_file

echo download the frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>log_file

cd /usr/share/nginx/html >>log_file

echo extracting the forntend code
unzip /tmp/frontend.zip >>log_file

echo starting the nginx service
systemctl enable nginx >>log_file
systemctl restart nginx >>log_file