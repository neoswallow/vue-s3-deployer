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

# invalidate index.html
if [[ $INPUT_AWS_CLOUDFRONT_DIST_ID != '' && $INPUT_AWS_INVALIDATION_PATH != '' ]]; then
  aws cloudfront create-invalidation \
      --distribution-id $INPUT_AWS_CLOUDFRONT_DIST_ID \
      --paths "$INPUT_AWS_INVALIDATION_PATH"
fi
