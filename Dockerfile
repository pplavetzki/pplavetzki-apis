#first stage - builder
FROM golang:1.13.1-stretch as builder

ENV GO111MODULE=on
WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY pkg/ .
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

#second stage
FROM alpine:latest
WORKDIR /root/
RUN apk add --no-cache tzdata
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /tmp/apis .

CMD ["./apis"]