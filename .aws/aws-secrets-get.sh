#!/usr/bin/env bash
set -e

# aws-secrets-get
#   Retrieve an encrypted secrets file from s3 and print it to stdout.
# bash aws-secrets-get.sh key-alias-ENV my-s3-bucket other/testkey2.enc
# Based on: https://github.com/promptworks/aws-secrets/blob/master/bin/aws-secrets-send

die() {
    echo "$@"
    exit
}
# set args
kms_alias=$1
s3_bucket=$2
s3_key=$3
[ -z "$kms_alias" ] && die "Missing KMS Alias.  Usage: $0 <app>";
[ -z "$s3_bucket" ] && die "Missing s3 bucket.  Usage: $1 <app>";
[ -z "$s3_key" ] && die "Missing s3 key.  Usage: $2 <app>";

s3_key=$s3_key
s3_bucket=$s3_bucket
kms_alias=$kms_alias

tmp=`mktemp -d`

aws s3api get-object --bucket $s3_bucket --key $s3_key $tmp/out > /tmp/errs

aws kms decrypt  --ciphertext-blob fileb://$tmp/out --output text --query Plaintext | base64 --decode