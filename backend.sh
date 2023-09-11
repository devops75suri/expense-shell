source common.sh
component=backend

type npm&>>$log_file
if [ $? -n 0 ]; then

  echo getting the node js repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  stat_check

  echo installing node js pack
  dnf install nodejs -y &>>$log_file
  stat_check
fi

echo copying back end servicess
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo adding user
id expense &>>$log_file
if [ $? -ne 0 ]; then
 useradd expense &>>$log_file
fi
stat_check

echo createing directory
id app &>>$log_file
if [ $? -ne 1 ]; then
 mkdir /app &>>$log_file
fi
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
id backend &>>$log_file
stat_check

echo start backend servicess
systemctl daemon-reload
systemctl enable backend
systemctl start backend
stat_check

echo installing the mysql
id mysql &>>$log_file
if [ $? -ne 0 ]; then
dnf install mysql -y &>>$log_file
fi
stat_check

echo load schema
mysql -h mysql.devops75.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check