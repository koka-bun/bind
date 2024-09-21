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

interface ServeOptions {
    port: number | null;
}

type ServerCallback = (context: ServerRequest) => ServerResponse;

export default function server(
    options: ServeOptions | null,
    fetch: (request: ServerRequest) => ServerResponse,
) {
    Bun.serve({
        port: options?.port ?? undefined,
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
            const response = fetch(requestObject);
            return new Response(response.body?.value ?? null, {
                status: response.status,
                headers: response.headers ?? {}
            });
        }
    });
}
