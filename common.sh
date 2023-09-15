log_file=/tmp/expense.log

download_and_extract(){

echo download the $component code
curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo failed
fi

echo extracting the $component code
unzip /tmp/$component.zip &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCESS
else
  echo failed
fi

}

