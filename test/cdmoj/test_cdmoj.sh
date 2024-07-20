#!/bin/bash

jobs_amount=$1

echo $jobs_amount | python3 cdmoj_push_jobs.py

python3 process_jobs.py
