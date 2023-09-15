source common.sh

echo install node js repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file

echo installing the node js
dnf install nodejs -y >>$log_file

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo add appilication user
useradd expense >>$log_file

echo cleaing app content
rm -rf /app >>$log_file
mkdir /app >>$log_file

echo download app content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>$log_file


cd /app >>$log_file

echo extract app content
unzip /tmp/backend.zip >>$log_file


echo download dependencioes
npm install >>$log_file

echo start backend service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo instal my sql  client
dnf install mysql -y >>$log_file

echo load the schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file