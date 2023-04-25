export interface LambdaReturnType  {
    statusCode: number;
    body?: string; 
}

const successMessage = {
    statusCode: 200
}

export class BaseHandler {
    constructor() {}
    handleError (code: number, message? : string): LambdaReturnType {
        const returnVal = JSON.parse(JSON.stringify(successMessage))
        returnVal.statusCode = code;

        if (message) {
            returnVal.body = message;
        }
        console.log(`RETURNING:: ${JSON.stringify(returnVal) }`)
        return returnVal
    }
    handleReturn (returnObject: string | any): LambdaReturnType {
        const returnVal = JSON.parse(JSON.stringify(successMessage))
        if (typeof returnObject === 'string') {
            returnVal.body = returnObject;
        } else {
            returnVal.body = returnObject
        }
        console.log(`RETURNING:: ${JSON.stringify(returnVal) }`)
        return returnVal
    }
}