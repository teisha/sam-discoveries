export interface LambdaReturnType  {
    statusCode: number;
    message?: string; 
}

export class BaseHandler {
    constructor() {}
    handleError (code: number, message? : string): LambdaReturnType {
        const returnVal: LambdaReturnType =  {
            statusCode: code
        }
        if (message) {
            returnVal.message = message;
        }
        return returnVal
    }
    handleReturn (message: string): LambdaReturnType {
        return {
            statusCode: 200,
            message: message
        } 
    }
}