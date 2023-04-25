import { BaseHandler } from "../../BaseLambda";
import { EventAfterTransform } from "../../models/EventAfterTransform";
import { EventWithId } from "../../models/EventWithId";





export class TransformLambda extends BaseHandler {
    handler(event: EventWithId) {
        console.log(event)
        const returnVal: EventAfterTransform = {
            ...event,
            backwards: event.id.split("").reverse().join("")
        }

        return this.handleReturn(returnVal)
    }
}