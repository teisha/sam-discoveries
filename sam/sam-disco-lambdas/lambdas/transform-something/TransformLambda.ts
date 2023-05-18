import { BaseHandler } from "../../BaseLambda";
import { EventAfterTransform } from "../../models/EventAfterTransform";
import { EventWithId } from "../../models/EventWithId";





export class TransformLambda extends BaseHandler {
    handler(event: EventWithId) {
        console.log(event)
        const data = event.body
        const returnVal = {
            ...data,
            backwards: data.id.split("").reverse().join("")
        }
        return this.handleReturn(returnVal)
    }
}