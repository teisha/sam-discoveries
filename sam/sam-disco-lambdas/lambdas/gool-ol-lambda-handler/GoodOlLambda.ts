import { BaseHandler } from "../../BaseLambda";
import { v4 as uuidv4 } from 'uuid'


export type IncomingEvent = {
    wordValue: string;
}

export class GoodOlHandler extends BaseHandler {
    handler(event: IncomingEvent) {
        if (event.wordValue) {
            const werd = event.wordValue;
            console.log(werd)
            if (werd === "ERRORME") {
                return this.handleError(300, "You got yourself an error");
            } else {
                return this.handleReturn({
                    ...event,
                    id: uuidv4()
                })
            }
        }
        throw new Error ("Where's my word?")
    }
}