#first stage - builder
FROM golang:1.13.1-stretch as builder

ENV GO111MODULE=on
WORKDIR /app/pplavetzki-apis

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o apis

#second stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/pplavetzki-apis/apis /app/

ENTRYPOINT ["/app/apis"]

EXPOSE 8080