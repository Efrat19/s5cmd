FROM golang:1.25.4-alpine3.22 AS build
COPY . /s5cmd/
RUN apk add --no-cache git make && \
    cd /s5cmd/ && \
    CGO_ENABLED=0 make build

FROM alpine:3.22
COPY --from=build /s5cmd/s5cmd .
WORKDIR /aws
ENTRYPOINT ["/s5cmd"]
