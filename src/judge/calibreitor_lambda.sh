#!/bin/bash

current_script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

parent_dir="$(dirname "$current_script_dir")"

cp -r $parent_dir/judge /tmp/judge
bash /tmp/judge/calibreitor.sh /tmp/judge/$1