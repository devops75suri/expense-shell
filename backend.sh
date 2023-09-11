source common.sh
component=backend


echo getting the node js repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
stat_check

echo installing node js pack
dnf install nodejs -y &>>$log_file
stat_check

echo copying back end servicess
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo adding user
useradd expense &>>$log_file
stat_check

echo createing directory
mkdir /app &>>$log_file
stat_check


download_and_extract

#echo downloading the backend servicess
#curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

#echo unziping or extarcat the package
#unzip /tmp/backend.zip &>>$log_file

echo changing the directory
cd /app &>>$log_file
stat_check

echo installing the backend servicess
npm install &>>$log_file
stat_check

echo start backend servicess
systemctl daemon-reload
systemctl enable backend
systemctl start backend
stat_check

echo installing the mysql service
dnf install mysql -y &>>$log_file
stat_check

echo load schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check