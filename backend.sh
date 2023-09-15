source common.sh
component=backend  # is a local variable

echo install node js repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
echo $?

echo installing the node js
dnf install nodejs -y &>>$log_file
echo $?

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

echo add appilication user
useradd expense &>>$log_file
echo $?

echo clean app content
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
cd /app
echo $?

#echo download app content
#curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

#echo extract app content
#unzip /tmp/backend.zip &>>$log_file

download_and_extract

echo download dependencies
npm install &>>$log_file
echo $?

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?

echo instal my sql  client
dnf install mysql -y &>>$log_file
echo $?

echo load the schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?
