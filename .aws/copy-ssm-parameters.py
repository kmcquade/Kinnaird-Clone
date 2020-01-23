#!/usr/bin/env python
#
# copy all SSM parameter store parameters to disk
#
import os, sys, argparse, boto3

parser = argparse.ArgumentParser(description='copy all parameter values to local')
parser.add_argument("--path", dest="path", required=True,
                    help="to copy the keys from", metavar="STRING")
parser.add_argument("--directory", dest="directory", required=True,
                    help="to write the keys into", metavar="FILE")
parser.add_argument("--recursive", dest="recursive", action="store_true", default=False, help="copy")
options = parser.parse_args()

if not os.path.isdir(options.directory):
    try:
        os.makedirs(options.directory)
    except OSError as e:
        parser.error('could not create directory {}'.format(e))

ssm = boto3.client('ssm')
paginator = ssm.get_paginator('get_parameters_by_path')
count = 0
for page in paginator.paginate(Path=options.path, WithDecryption=True, Recursive=options.recursive):
    for parameter in page['Parameters']:
        count += 1
        dirname = os.path.dirname(parameter['Name'])[len(options.path) + 1:]
        targetdir = os.path.join(options.directory, dirname)
        basename = os.path.basename(parameter['Name'])
        filepath = os.path.join(targetdir, basename)
        sys.stderr.write('INFO: copying parameter {} from {} to {}.\n'.format(basename, dirname, options.directory))
        if not os.path.isdir(targetdir):
            os.makedirs(os.path.dirname(filepath))

        with os.fdopen(os.open(filepath, os.O_WRONLY | os.O_CREAT, 0o600), 'w') as handle:
            handle.write(parameter['Value'])
sys.stderr.write('INFO: {} parameters copied.\n'.format(count))
