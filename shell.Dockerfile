FROM rust:latest

# INSTALL DEPENDENCIES
RUN apt update
RUN apt install protobuf-compiler ca-certificates -y

# CLIENT
WORKDIR /app
RUN git clone https://github.com/ehlkristofhenrik/bonfire-client.git bonfire-client-src
WORKDIR /app/bonfire-client-src
RUN echo 'SERVER_ADDR="https://127.0.0.1:2345"' > .env
RUN cargo build --features=dummy --release
RUN cp /app/bonfire-client-src/target/release/bonfire-client /app/bonfire-client

# SHELL
WORKDIR /app
RUN git clone https://github.com/ehlkristofhenrik/bonfire-shell.git bonfire-shell-src
WORKDIR /app/bonfire-shell-src
RUN cargo build --release
RUN cp /app/bonfire-shell-src/target/release/bonfire-shell /app/bonfire-shell

WORKDIR /app
CMD /app/bonfire-shell