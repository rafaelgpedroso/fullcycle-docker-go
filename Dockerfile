FROM golang:1.24.1-alpine AS builder

RUN mkdir /app

COPY ./app /app

WORKDIR /app

RUN go mod init fullcycle-go

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM scratch

COPY --from=builder /app/main .

CMD ["./main"]