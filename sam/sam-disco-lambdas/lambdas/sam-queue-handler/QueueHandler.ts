import { SQSEvent } from "aws-lambda";
import { S3Service } from "../../services/s3Service";
import { BaseHandler } from "../../BaseLambda";
import { EventWorthSaving } from "../../models/EventWorthSaving";

export class QueueHandler extends BaseHandler {

    constructor (private s3Service: S3Service, private bucketName: string) {
        super();
    }

    async handle(event: SQSEvent) {
        try {
            for (let rec of event.Records) {
                const saveableRec = JSON.parse(rec.body) as EventWorthSaving
                await this.saveRecToS3(saveableRec)
            }
            return this.handleReturn(`${event.Records.length} records saved to ${this.bucketName}`)
        } catch (error) {
            console.log ({error})
            return this.handleError(300, (error as unknown as Error).message)
        }

    }

    private async saveRecToS3 (saveMe: EventWorthSaving) {
        const res = await this.s3Service.put(this.bucketName, `saveable/${saveMe.id}.txt`, JSON.stringify(saveMe));
        console.log({res})
    }
}