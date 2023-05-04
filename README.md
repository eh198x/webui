# Full-stack Go

WebUI [WebUI Logo](https://path-to-logo/logo.png). It's a full-stack Go web application called "WebUI" that lets users to upload files over https.

<img width="500" src="./webui.png" />

### Features

- Authentication. Users can register and sign in.
- Protected endpoints. Only signed-in users can create snippets.
- RESTful routing.
- Middleware.
- Postgres database.
- SSL/TLS web server using HTTP 2.0.
- Generated HTML via Golang templates.
- CRSF protection.

### Development

##### `go run cmd/web/*`

Starts the local web server with HTTPS on port 4000 ([https://localhost:4000](https://localhost:4000))
