export interface EventWithId  {
    statusCode: number;
    body: {
        id: string;
        wordValue: string;
    }

}