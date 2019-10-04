#first stage - builder
FROM golang:1.13.1-stretch as setup

ENV GO111MODULE=on
WORKDIR /app/pplavetzki-apis

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY ./pkg/ ./pkg/
COPY ./main.go .
COPY ./swagger.json .

FROM setup as builder

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o apis

#second stage
FROM alpine:latest as executable
COPY --from=builder /app/pplavetzki-apis/apis /app/
COPY --from=builder /app/pplavetzki-apis/swagger.json /app/
WORKDIR /app/

ENTRYPOINT ["/app/apis"]

EXPOSE 8080

FROM setup as testrunner

ENTRYPOINT ["go"]
CMD ["test", "./..."]