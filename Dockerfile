FROM golang:1.22-alpine AS builder

WORKDIR /usr/local/src

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . ./

RUN go build -o ./bin/main main.go

FROM alpine AS runner

COPY --from=builder /usr/local/src/bin/main /

COPY port.env /

CMD ["/main"]
