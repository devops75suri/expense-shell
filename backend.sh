source common.sh
component=backend  # is a local variable

type npm &>>$log_file
  if [ $? -ne 0 ]; then
  echo install node js repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  stat_check

  echo install node js
  dnf install nodejs -y &>>$log_file
  stat_check
  fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo add application user
id expense &>>$log_file
if [ $? -ne 0 ]; then
  useradd expense &>>$log_file
fi
stat_check

echo clean app content
rm -rf /app &>>$log_file
mkdir /app &>>$log_file
cd /app
stat_check

#echo download app content
#curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

#echo extract app content
#unzip /tmp/backend.zip &>>$log_file

download_and_extract

echo download dependencies
npm install &>>$log_file
stat_check

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo instal my sql  client
dnf install mysql -y &>>$log_file
stat_check

echo load the schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check
