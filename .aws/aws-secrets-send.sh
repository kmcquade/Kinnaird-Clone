#!/usr/bin/env bash
set -e

# aws-secrets-send
#   Encrypt a file using a KMS key alias, then send it to an s3 bucket.
#   Based on: https://github.com/promptworks/aws-secrets/blob/master/bin/aws-secrets-send

# bash aws-secrets-send.sh super-secret-key.pem key-alias-ENV my-s3-bucket other/testkey2.enc 1
die() {
    echo "$@"
    exit
}

secrets_file=$1
kms_alias=$2
s3_bucket=$3
s3_key=$4
upload=$5

[ -z "$secrets_file" ] && die "Missing filename.  Usage: $0 <app> <filename>";
[ -z "$kms_alias" ] && die "Missing kms_alias.  Usage: $0 <app> ";
[ -z "$s3_bucket" ] && die "Missing s3_bucket.  Usage: $0 <app> ";
[ -z "$s3_key" ] && die "Missing s3_key.  Usage: $0 <app> ";
[ -z "$upload" ] && die "Missing upload flag.  Usage: $0 <app> ";

src=$secrets_file
s3_bucket=$s3_bucket
s3_key=$s3_key
kms_alias=$kms_alias

tmp=`mktemp -d`
encrypted=$tmp/data.enc

key_id=`aws kms list-aliases --output text --query "Aliases[?AliasName=='alias/$kms_alias'].TargetKeyId | [0]"`

echo "Encrypting with KMS"
aws kms encrypt \
    --key-id $key_id \
    --plaintext fileb://$src \
    --query CiphertextBlob \
    --output text \
    | base64 --decode \
    > $encrypted

if [ $upload = "1" ]; then
    aws s3api put-object \
        --bucket $s3_bucket \
        --key $s3_key \
        --acl private \
        --body $encrypted \
        --output text \
        --query 'None' \
        | egrep -v '^None$' || true
    echo "Uploaded to S3 at given path!"
else
    echo "Encrypted but not uploaded!"
fi
rm -rf $tmp