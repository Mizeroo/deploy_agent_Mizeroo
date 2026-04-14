#!/usr/bin/env bash
# My summative on Linux and its application


# Step 1: Get directory name from user
read -p "Enter desired directory name: " input

# Step 2: Create main directory
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input

# Step 3: Create Helpers subdirectory
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers

# Step 4: Create reports subdirectory
mkdir /deploy_agent_Mizeroo/attendance_tracker_$input/reports

# Step 5: Copy attendance_checker.py to main directory
cp /deploy_agent_Mizeroo/attendance_checker.py /deploy_agent_Mizeroo/attendance_tracker_$input/

# Step 6: Copy assets.csv and config.json to Helpers
cp /deploy_agent_Mizeroo/assets.csv /deploy_agent_Mizeroo/config.json /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/

# Step 7: copy reports.log to reports
cp /deploy_agent_Mizeroo/reports.log  /deploy_agent_Mizeroo/attendance_tracker_$input/reports/

# Step 8: Ask user about updating attendance threshold
read -p "Do you want to update the attendance threshold? (Yes/No): " answer

if [ "$answer" = "yes" ]; then
    read -p "Enter new value for Warning (default 75%): " new_warning_value
    read -p "Enter new value for Failure (default 50%): " new_failure_value
    sed -i "s/75/$new_warning_value/" /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json
    sed -i "s/50/$new_failure_value/" /deploy_agent_Mizeroo/attendance_tracker_$input/Helpers/config.json
else
    echo "Keeping default warning and failing values."
fi

# Step 9: Set trap to archive directory on CTRL+C/SIGINT
trap 'tar -czf attendance_tracker_${input}_archive /deploy_agent_Mizeroo/attendance_tracker_$input; exit 1' SIGINT

# Step 10: Remove directory if empty, otherwise notify user
if [ -z "$(ls /deploy_agent_Mizeroo/attendance_tracker_$input)" ]; then
    rm -r /deploy_agent_Mizeroo/attendance_tracker_$input
else
    echo "Directory not empty."
fi
# step 11: do the health check

if python3 --version > /dev/null 2>&1; then

        echo "✔ Python3 is installed"
else
        echo " ⚠ Warning: Python3 not installed"
 fi

git add .
git commit -m "this is my summative submission on Linux."
git push


