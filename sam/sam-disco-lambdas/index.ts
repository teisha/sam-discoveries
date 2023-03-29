import { S3Client } from "@aws-sdk/client-s3";
import { SNSEvent, SQSEvent } from "aws-lambda";
import { Env } from "./services/environmentService";
import { S3Service } from "./services/s3Service";
import { QueueHandler } from "./lambdas/sam-queue-handler/QueueHandler";
import { GoodOlHandler, IncomingEvent } from "./lambdas/gool-ol-lambda-handler/GoodOlLambda";



export const queueHandler = async (event: SQSEvent) => {
    const s3Client = new S3Client({region: Env.getVal('REGION', 'us-east-1')})
    const s3Service = new S3Service(s3Client)
    const handler = new QueueHandler(s3Service, Env.getVal('BUCKET'))
    return handler.handle(event)

}

export const goodOlLambdaHandler = async (event: IncomingEvent ) => {
    const handler = new GoodOlHandler();
    return handler.handler(event)

}