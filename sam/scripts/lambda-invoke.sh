
echo "FIRST"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-CreateQueuePro-SamEventHandler-ksbpbget1Zho" \
--invocation-type RequestResponse \
--cli-binary-format raw-in-base64-out \
--payload '{"id":"id-1","name":"Hello World", "description": "Adopt easilt the best practices in your apps"}' \
dist/response.txt


# Error message
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "Hello World"
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "I DEMAND TO SEE THE DEAD LETTER QUEUE"
# Success message
# aws sns publish --topic-arn arn:aws:sns:us-east-1:001668627821:sam-disco-infra-experiment-dev --message "{\"id\":\"id-1\",\"name\":\"Hello World\", \"description\": \"Adopt easilt the best practices in your apps\"}"

echo "SECOND"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-CreateQueuePro-SamEventHandler-ksbpbget1Zho" \
--invocation-type Event \
--cli-binary-format raw-in-base64-out \
--payload 'Hello World' \
dist/response.txt

# An error occurred (InvalidRequestContentException) when calling the Invoke operation: Could not parse request body into json: Could not parse payload into json: Unrecognized token 'Hello': was expecting (JSON String, Number, Array, Object or token 'null', 'true' or 'false')
#  at [Source: (byte[])"Hello World"; line: 1, column: 7]

echo "THIRD"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-CreateQueuePro-SamEventHandler-ksbpbget1Zho" \
--invocation-type Event \
--cli-binary-format raw-in-base64-out \
--payload 'I DEMAND TO SEE THE DEAD LETTER QUEUE' \
dist/response.txt

echo "FOURTH {} - RequestResponse"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-GoodOlHandler-mNthj9Dsxmxe" \
--invocation-type RequestResponse \
--cli-binary-format raw-in-base64-out \
--payload '{}' \
dist/response-Response-4.txt

echo "FIFTH {} - Event"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-GoodOlHandler-mNthj9Dsxmxe" \
--invocation-type Event \
--cli-binary-format raw-in-base64-out \
--payload '{}' \
dist/response-Event-5.txt

echo "SIXTH '{\"wordValue\": \"I DEMAND TO SEE THE DEAD LETTER QUEUE\"}'"

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-GoodOlHandler-mNthj9Dsxmxe" \
--invocation-type RequestResponse \
--cli-binary-format raw-in-base64-out \
--payload '{"wordValue": "I DEMAND TO SEE THE DEAD LETTER QUEUE"}' \
dist/response-Response-6.txt

echo "SEVENTH  - ERRORME" 

aws lambda invoke --function-name "arn:aws:lambda:us-east-1:001668627821:function:sam-disco-infra-dev-GoodOlHandler-mNthj9Dsxmxe" \
--invocation-type RequestResponse \
--cli-binary-format raw-in-base64-out \
--payload '{"wordValue": "ERRORME"}' \
dist/response-Response-7.txt