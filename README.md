## How to Run the Script

1. **Clone the repository


create  file/script setup_project.sh

2. **Make the script executable:**


chmod +x setup_project.sh


3. **Run the script:**

to do this , there is there ways

source setup_project.sh
bash setup_project.sh
./setup_project.sh
./setup_project.sh


4. **Follow the prompts:**

   - Enter a project name (v1 → `attendance_tracker_v1`)
   
        ask user  whether to update the attendance thresholds:
     - **Warning threshold** (default: `75%`)
     - **Failure threshold** (default: `50%`)
   - The script will apply your values directly into `config.json` using `sed`


## How to Trigger the Archive Feature (SIGINT / Ctrl+C)

The script includes a **signal trap** that handles interruptions gracefully.

**To trigger it:**

While the script is running, press:


Ctrl + C

**What happens:**

1. The script catches the `SIGINT` signal
2. It bundles the current (incomplete) project directory into a compressed archive:
   
   attendance_tracker_{input}_archive
   
3. The incomplete project directory is deleted to keep the workspace clean

4. The script exits safely

> This ensures that even if you cancel mid-execution, you don't lose your work — the archive preserves the state at the time of interruption.


## link to the video explaining how i approached this task

[Video for demostartion](https://www.youtube.com/watch?v=TJk0Q71wAYM)

