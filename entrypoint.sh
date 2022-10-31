#!/usr/bin/env bash

# move to app source code
cd $INPUT_APP_SOURCE_CODE

# install dependencies
echo "Installing dependencies"
npm install > /dev/null 2>&1

# build application
echo "Building application"

# execute the command provided
`echo $INPUT_BUILD_COMMAND` 

# sync files with Amazon S3 bucket app
aws --region $INPUT_AWS_DEFAULT_REGION s3 sync ./dist s3://$INPUT_AWS_BUCKET_NAME --no-progress --delete --acl public-read
