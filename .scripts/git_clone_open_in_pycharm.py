#!/usr/bin/env python3
import os
import subprocess
import argparse
from pathlib import Path
import re

parser = argparse.ArgumentParser(
    description='Run Git Clone and open the repository in PyCharm'
)
parser.add_argument(
    "--url",
    "-u",
    dest="url",
    required=True,
    help="The GitHub repository, like git@github.com:username/repository.git"
)
# Example:
"""
git_clone_open_in_pycharm.py --url git@github.com:pyupio/pyup.git
"""
args = parser.parse_args()
HOME = str(Path.home())
GITHUB_DIRECTORY = os.path.join(HOME, "Code", "github.com")
url = args.url
if not os.path.isdir(GITHUB_DIRECTORY):
    try:
        os.makedirs(GITHUB_DIRECTORY)
    except OSError as e:
        parser.error('could not create directory {}'.format(e))

# git_url_pattern = "((git@|http(s)?:\/\/)([\w\.@]+)(\/|:))([\w,\-,\_]+)\/([\w,\-,\_]+)(.git){0,1}((\/){0,1})"
# assert re.match(url, git_url_pattern)

# Get the username and repo_name
u_repo_str = url.replace("git@github.com:", "")  # pyupio/pyup.git
username = u_repo_str.split("/")[0]  # pyupio
repo_name = u_repo_str.split("/")[1].replace(".git", "")  # pyup

TARGET_DIRECTORY = os.path.join(GITHUB_DIRECTORY, username, repo_name)
if not os.path.isdir(TARGET_DIRECTORY):
    try:
        os.makedirs(TARGET_DIRECTORY)
    except OSError as e:
        parser.error('could not create directory {}'.format(e))

print(f"Cloning the Git repository to {TARGET_DIRECTORY}")
process = subprocess.Popen(["git", "clone", url, TARGET_DIRECTORY], stdout=subprocess.PIPE)
output = process.communicate()[0]
# print(output)

print(f"Opening the Git repository in Pycharm")
process = subprocess.Popen(["pycharm", TARGET_DIRECTORY], stdout=subprocess.PIPE)
output_2 = process.communicate()[0]

