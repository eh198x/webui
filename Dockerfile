FROM golang:1.20.4 as builder

WORKDIR /usr/src/app

COPY . .
RUN go mod tidy
RUN env GOOS=linux GARCH=amd64 CGO_ENABLED=0 go build -o=/webui ./cmd/api

FROM alpine:latest as production

WORKDIR /

COPY --from=builder /webui /webui

ENTRYPOINT ["./webui" ]