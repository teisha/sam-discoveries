set -e

PROFILE=lsoft  # profile for target instance
REGION=us-east-1

# Must be created manually
BUCKET="serverless-deploy-all-lsft-projects"

# General parameters
CLIENT="sam-disco"
PROJECT="infra"
ENVIRONMENT="dev"
STACK_NAME="$CLIENT-$PROJECT-$ENVIRONMENT"
TEMPLATE="template.yaml"
DEPLOY_CUSTOM_HANDLER="false"

# Build sam-disco-cloudformation
echo "Building Sam Discovery Infra project"

# # Build sam-disco-lambdas
# echo "Building Sam Discovery Lambdas"
# npm install -D
# node esbuild.js

# pwd



sam build --template $TEMPLATE \
&& sam deploy \
  --template $TEMPLATE \
  --stack-name $STACK_NAME \
  --s3-bucket $BUCKET \
  --s3-prefix $STACK_NAME \
  --tags \
    "Client"=$CLIENT \
    "Project"=$PROJECT \
    "Environment"=$ENVIRONMENT \
  --parameter-overrides \
    ParameterKey=Client,ParameterValue=$CLIENT \
    ParameterKey=Project,ParameterValue=$PROJECT \
    ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
    ParameterKey=CustomCTRProcessing,ParameterValue=$DEPLOY_CUSTOM_HANDLER \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region $REGION \
  --profile $PROFILE



# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "Hello World"