#!/usr/bin/env bash
# Automated Task
# Step 1 - Prompt user for directory name
read -p "Enter desired directory name: " input

# Step 2 - Create project directory structure
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/reports/

# Step 3 - Copy source files into project
cp /deploy_agent_Mizeroo/attendance_checker.py /deploy_agent_Mizeroo/attendance_tracker_$input/
cp /deploy_agent_Mizeroo/assets.csv /deploy_agent_Mizeroo/config.json /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers
cp /deploy_agent_Mizeroo/reports.log  /deploy_agent_Mizeroo/attendance_tracker_$input/reports/

# Step 4 - Prompt the user to update attendance threshold in config.json file
read -p "Do you want to update the attendance threshold? (Yes/No): " answer

# Step 5 - Collect new threshold values if yes
if [ "$answer" = "yes" ]; then
    read -p "Enter new value for Warning (default 75%): " new_warning_value
    read -p "Enter new value for Failure (default 50%): " new_failure_value

# Step 6 - Apply new threshold values to config.json file
 sed -i "s/75/$new_warning_value/"  /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json
    sed -i "s/50/$new_failure_value/" /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json
else
    echo " warning and failure values not changed."
fi

# Step 7 - Set interrupt trap to archive on exit
trap 'tar -czf attendance_tracker_${input}_archive /deploy_agent_Mizeroo/attendance_tracker_$input; exit 1' SIGINT

# Step 8 - Remove directory if empty
if [ -z "$(ls /deploy_agent_Mizeroo/attendance_tracker_$input)" ]; then
    rm -r /deploy_agent_Mizeroo/attendance_tracker_$input
else
    echo "Directory not empty."
fi

# Step 9 - Verify if Python3 is installed
if python3 --version > /dev/null 2>&1; then
        echo "Python 3 is installed."
else
        echo " Python3 not installed."
 fi

# Step 10 - Stage and commit changes
git add .
git commit -m "set up student attendance tracker."

# Step 11 - Push to remote repository
git push
