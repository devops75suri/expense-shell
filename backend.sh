source common.sh

echo getting the node js repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>log_file

echo installing node js pack
dnf install nodejs -y >>log_file

echo copying back end servicess
cp backend.service /etc/systemd/system/backend.service >>log_file

echo adding user
useradd expense >>log_file

echo createing directory
mkdir /app >>log_file

echo downloading the backend servicess
curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>log_file

echo changing the directory
cd /app >>log_file

echo unziping the package
unzip /tmp/backend.zip >>log_file

echo installing the backend servicess
npm install >>log_file

systemctl daemon-reload

systemctl enable backend
systemctl start backend

echo installing the mysql service
dnf install mysql -y >>log_file

echo load schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>log_file
