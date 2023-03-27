export class Env {

    static getVal(name: string, defaultValue?: string) {
        return process.env[name] ?? defaultValue ?? '';
    }
}