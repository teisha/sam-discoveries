import { BaseHandler } from "../../BaseLambda";
import { EventAfterTransform } from "../../models/EventAfterTransform";


export type IncomingEvent = {
    wordValue: string;
}

export class AddLookupHandler extends BaseHandler {
    handler(event: EventAfterTransform) {
        console.log(event)
        const data = event.body
        console.log(data)
        let {backwards, ...returnVal} = data;
        return this.handleReturn({
            ...returnVal,
            description: `Pretend something got looked up for ${backwards}`
        })
    }
}