FROM golang:1.13.6-alpine3.11 as build

ENV API_PORT=9000

WORKDIR /app

RUN mkdir ./bin

COPY go.* ./

RUN go mod download

COPY main.go ./

RUN go build -mod vendor -i -v -o /app/bin/server /app

VOLUME /app

# prod
FROM alpine:3.11

RUN apk add --no-cache ca-certificates

COPY --from=build /app/bin/server /app/bin/server

CMD ["/app/bin/server"]