FROM golang:1.16.6-alpine3.14 as build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /server-files



FROM alpine:3.14.2

RUN apk --no-cache add ca-certificates

WORKDIR /
COPY --from=build /server-files ./

EXPOSE 8080

CMD [ "/server-files" ]