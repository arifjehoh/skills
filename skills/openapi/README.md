# openapi

Generate an `openapi.yaml` file at the project root by scanning the codebase for every exposed endpoint, with OAuth2 security declared once at the top level so all paths inherit it.

## What it does

1. Scans the project for route definitions across common frameworks (Express, Koa, Fastify, NestJS, Spring, FastAPI, Flask, Django, Go net/http/gin/echo, ASP.NET Core).
2. Resolves project title/version from the nearest manifest file.
3. Defines a single `oauth2` security scheme (`clientCredentials` flow) under `components.securitySchemes`, and applies it once via a top-level `security` field — every path/operation inherits it per the OpenAPI spec, so it's never repeated per endpoint.
4. Builds the `paths` section from the discovered endpoints.
5. Writes `openapi.yaml` to the project root (asks before overwriting).
6. Validates the file with a spec linter if one is available in the project.
7. Reports a summary, including the required variables.

## How to invoke

```
/openapi
```

Also triggers on phrases like "generate an openapi spec", "document the API".

## Variables you must supply

The generated spec references three placeholders that you fill in (via env substitution, CI secrets, or your API client config) before making authenticated calls:

- `ACCESS_TOKEN_URL` — the OAuth2 token endpoint
- `CLIENT_ID`
- `CLIENT_SECRET`

## Example

```bash
$ cd my-api-project
$ /openapi
```

Produces `./openapi.yaml`:

```yaml
openapi: 3.0.3
info:
  title: my-api-project
  version: 1.0.0
components:
  securitySchemes:
    oauth2:
      type: oauth2
      flows:
        clientCredentials:
          tokenUrl: {{ACCESS_TOKEN_URL}}
          scopes: {}
      x-client-id: {{CLIENT_ID}}
      x-client-secret: {{CLIENT_SECRET}}
security:
  - oauth2: []
paths:
  /users:
    get:
      summary: List users
    post:
      summary: Create user
```

Every path inherits the top-level `security` block — no per-endpoint repetition.

## Boundaries

Only discovers endpoints via static pattern matching in source files; it does not fabricate request/response schemas. Does not store real credentials — always uses placeholder variables.
