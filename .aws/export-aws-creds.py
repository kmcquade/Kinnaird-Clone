#!/usr/bin/python

# Usage with non-default profile:
#   export-aws-creds.py --profile custom
# Usage (without --profile, looks for default):
#   export-aws-creds.py
# Simple script that parses the ~/.aws/credentials file and creates the `export`
# command needed for pumping your AWS creds to command line.

import configparser
import argparse
from os.path import expanduser

# awsconfigfile: AWS credentials file
awsconfigfile = '/.aws/credentials'
home = expanduser("~")
filename = home + awsconfigfile

# Receive the profile name from "--profile default"
parser = argparse.ArgumentParser(description='Print out the export commands.')
parser.add_argument('--profile', metavar='N', type=str, default='default',
                    help='profile name')

args = parser.parse_args()
aws_profile_name = str(args.profile)
config = configparser.ConfigParser()
config.read(filename)

access_key = config.get(aws_profile_name, 'aws_access_key_id')
secret_key = config.get(aws_profile_name, 'aws_secret_access_key')
session_token = ''
security_token = ''

session_token_exists = config.has_option(aws_profile_name,'aws_session_token')
if session_token_exists:
    session_token = config.get(aws_profile_name, 'aws_session_token')
else:
    print("No session token set for profile")

security_token_exists = config.has_option(aws_profile_name,'aws_security_token')
if security_token_exists:
    security_token = config.get(aws_profile_name, 'aws_security_token')
else:
    print("No security token set for profile")

print('')

ak_text = 'export AWS_ACCESS_KEY_ID='
sk_text = 'export AWS_SECRET_ACCESS_KEY='
session_token_text = 'export AWS_SESSION_TOKEN='
security_token_text = 'export AWS_SECURITY_TOKEN='

print('For speed purposes, copy and paste the following lines so you can set your environment variables in the terminal.')
print(ak_text + access_key)
print(sk_text + secret_key)

if session_token_exists:
    print(session_token_text + session_token)

if session_token_exists:
    print(session_token_text + security_token)