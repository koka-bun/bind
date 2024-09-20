type KokaString = {
    value: string;
}

interface ServerHeaders {
    [key: string]: string;
}

interface ServerRequest {
    url: string;
    method: string;
    headers: ServerHeaders;
    body: string | null;
}

interface ServerResponse {
    body: KokaString | null;
    status: number;
    headers: ServerHeaders | null;
}

type ServerCallback = (context: ServerRequest) => ServerResponse;

export default function server(port: number, callback: ServerCallback) {
    Bun.serve({
        port,
        fetch(request: Request) {
            const headers: ServerHeaders = {};
            request.headers.forEach((value, key) => {
                headers[key] = value;
            });
            const requestObject: ServerRequest = {
                url: request.url,
                method: request.method,
                headers,
                body: request.body?.toString() ?? null
            };
            const response = callback(requestObject);
            return new Response(response.body?.value ?? null, {
                status: response.status,
                headers: response.headers ?? {}
            });
        }
    });
}
