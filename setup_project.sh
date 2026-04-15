#!/usr/bin/env bash
# My summative on Linux and its application

read -p "Enter desired directory name: " input

mkdir /deploy_agent_Mizeroo/attendance_tracker_$input


mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/

mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/reports/

cp /deploy_agent_Mizeroo/attendance_checker.py /deploy_agent_Mizeroo/attendance_tracker_$input/

cp /deploy_agent_Mizeroo/assets.csv /deploy_agent_Mizeroo/config.json /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers
cp /deploy_agent_Mizeroo/reports.log  /deploy_agent_Mizeroo/attendance_tracker_$input/reports/


read -p "Do you want to update the attendance threshold? (Yes/No): " answer

if [ "$answer" = "yes" ]; then
    read -p "Enter new value for Warning (default 75%): " new_warning_value

    read -p "Enter new value for Failure (default 50%): " new_failure_value

 sed -i "s/75/$new_warning_value/"  /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json

    sed -i "s/50/$new_failure_value/" /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json

else
    echo "Keeping default warning and failing values."
fi


trap 'tar -czf attendance_tracker_${input}_archive /deploy_agent_Mizeroo/attendance_tracker_$input; exit 1' SIGINT


if [ -z "$(ls /deploy_agent_Mizeroo/attendance_tracker_$input)" ]; then

    rm -r /deploy_agent_Mizeroo/attendance_tracker_$input

else
    echo "Directory not empty."
fi


if python3 --version > /dev/null 2>&1; then

        echo "Python 3 is installed."
else
        echo " Python3 not installed."
 fi

git add .
git commit -m "this mu summative"
git push

