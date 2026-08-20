---
name: openapi
description: Generate an openapi.yaml file at the project root by scanning the codebase for every exposed endpoint. Use when the user says "/openapi", "generate an openapi spec", "document the API", or asks for an OpenAPI/Swagger file for this project.
---

Scan the project and produce a single `openapi.yaml` at the repo root, with OAuth2 security declared once at the top level so every path **inherits** it — no per-endpoint repetition.

## Steps

1. **Discover every endpoint.** Search the codebase for route definitions across whatever framework(s) it uses — do not assume one. Look for patterns like:
   - Express/Koa/Fastify: `app.get(`, `router.post(`, `.route(`
   - NestJS: `@Get(`, `@Post(`, `@Controller(`
   - Spring: `@RequestMapping`, `@GetMapping`, `@PostMapping`
   - FastAPI/Flask: `@app.get(`, `@router.post(`
   - Django: `urlpatterns`, `path(`
   - Go (net/http, gin, echo): `.GET(`, `.Handle(`, `router.HandleFunc(`
   - ASP.NET Core: `[HttpGet]`, `[Route(`

   Record method, path, and source file for each match. Completion: every route-defining file in the project has been checked — none skipped because the framework looked unfamiliar.

2. **Resolve project metadata.** Read `title` and `version` from the nearest manifest (`package.json`, `pom.xml`, `pyproject.toml`, `go.mod`, `.csproj`). If none is found, ask the user for a title.

3. **Write the security block once, at the top level.** Under `components.securitySchemes`, define a single `oauth2` scheme using the `clientCredentials` flow, with no `refreshUrl`:
   - `tokenUrl: {{ACCESS_TOKEN_URL}}`
   - `x-client-id: {{CLIENT_ID}}`
   - `x-client-secret: {{CLIENT_SECRET}}`

   Use the `{{VARIABLE_NAME}}` template-placeholder format, not `${VARIABLE_NAME}`. Then add a document-level `security: [{ oauth2: [] }]`. Per the OpenAPI spec, any path or operation that omits its own `security` field inherits this top-level one automatically — do not add `security` to individual paths/operations unless an endpoint is explicitly meant to be public (then set `security: []` on just that operation).

4. **Build the `paths` section.** Add one entry per endpoint found in step 1, grouped by path, with `summary` left as a short placeholder derived from the method/path (e.g. "List users") since request/response schemas can't be inferred reliably — note this limitation to the user rather than fabricating schemas.

5. **Write `openapi.yaml` to the project root.** If the file already exists, show a diff summary and ask before overwriting.

6. **Validate.** If a spec linter is available in the project (e.g. `npx @redocly/cli lint openapi.yaml`, `swagger-cli validate`), run it. Completion: lint passes, or — if no linter is available — the YAML at least parses cleanly.

7. **Report.** Tell the user: how many endpoints were found (and from which frameworks/files), where the file was written, and that they must supply `ACCESS_TOKEN_URL`, `CLIENT_ID`, and `CLIENT_SECRET` (e.g. via env substitution or their API tooling) before the spec is usable for authenticated calls.
