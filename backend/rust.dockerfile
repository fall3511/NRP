# Build Stage for the RUST Backend

FROM rust:1.75.0 as builder

WORKDIR /app

ARG DATABASE_URL

ENV DATABASE_URL=$DATABASE_URL

COPY . .

RUN cargo build --release

# Production Stage for the RUST Backend

FROM debian:stable-slim

WORKDIR /user/local/bin

COPY --from=builder /app/target/release/backend .

CMD [ "./backend" ]