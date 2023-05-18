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
cd sam-disco-lambdas
npm install -D
npm run build
cd ..

pwd

aws s3 cp ./deployConfigs/ "s3://$BUCKET/$CLIENT/$ENVIRONMENT" --recursive --include "*.json" --region $REGION --profile $PROFILE


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
    ParameterKey=DeployBucket,ParameterValue=$BUCKET \
    ParameterKey=Client,ParameterValue=$CLIENT \
    ParameterKey=Project,ParameterValue=$PROJECT \
    ParameterKey=Environment,ParameterValue=$ENVIRONMENT \
    ParameterKey=CustomCTRProcessing,ParameterValue=$DEPLOY_CUSTOM_HANDLER \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region $REGION \
  --profile $PROFILE


# Error message
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "Hello World"
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "I DEMAND TO SEE THE DEAD LETTER QUEUE"
# Success message
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "{\"id\":\"id-1\",\"name\":\"Hello World\", \"description\": \"Adopt easilt the best practices in your apps\"}"


# DELETE commands
# aws cloudformation delete-stack --stack-name sam-disco-infra-dev --region us-east-1 --profile lsoft
# aws dynamodb delete-table --table-name sam-disco-infra-dev-data-table --region us-east-1 --profile lsoft
