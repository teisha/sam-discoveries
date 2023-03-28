import { SNSEvent, SNSEventRecord, SNSMessage, SQSEvent } from "aws-lambda";
import { S3Service } from "../../services/s3Service";
import { BaseHandler } from "../../BaseLambda";
import { EventWorthSaving } from "../../models/EventWorthSaving";

export class QueueHandler extends BaseHandler {

    constructor (private s3Service: S3Service, private bucketName: string) {
        super();
    }

    async handle(event: SQSEvent) {
        console.log(JSON.stringify(event) )
        try {
            for (let rec of event.Records) {
                console.log(`Processing::  ${rec.messageId}`)
                const snsMessage = JSON.parse(rec.body) as SNSMessage
                console.log(`Message is ${JSON.stringify(snsMessage, null, 2)}`) 
                if (snsMessage.Message === "I DEMAND TO SEE THE DEAD LETTER QUEUE") {
                    throw new Error("DEAD")
                }
                const saveableRec = JSON.parse(snsMessage.Message) as EventWorthSaving
                await this.saveRecToS3(saveableRec)
            }
            return this.handleReturn(`${event.Records.length} records saved to ${this.bucketName}`)
        } catch (error) {
            console.log ({error})
            if ((error as unknown as Error).message === "DEAD") {
                throw error
            }
            return this.handleError(300, (error as unknown as Error).message)
        }

    }

    private async saveRecToS3 (saveMe: EventWorthSaving) {
        const res = await this.s3Service.put(this.bucketName, `saveable/${saveMe.id}.txt`, JSON.stringify(saveMe));
        console.log({res})
    }
}