import { BaseHandler } from "../../BaseLambda";
import { EventAfterTransform } from "../../models/EventAfterTransform";


export type IncomingEvent = {
    wordValue: string;
}

export class AddLookupHandler extends BaseHandler {
    handler(event: EventAfterTransform) {
        let {backwards: _, ...returnVal} = event;
        return this.handleReturn({
            ...returnVal,
            description: `Pretend something got looked up for ${event.backwards}`
        })
    }
}