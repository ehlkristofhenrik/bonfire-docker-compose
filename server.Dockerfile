FROM rust:latest

RUN apt update
RUN apt install protobuf-compiler ca-certificates nodejs -y


# SERVER
WORKDIR /app
RUN git clone https://github.com/ehlkristofhenrik/bonfire-server.git bonfire-server-src
WORKDIR /app/bonfire-server-src
RUN cargo build --release --features=github,llamafile

# ML
WORKDIR /app
RUN git clone https://github.com/ehlkristofhenrik/bonfire-ml.git bonfire-ml-src
WORKDIR /app/bonfire-ml-src
RUN cp /app/bonfire-server-src/target/release/bonfire-server /app/bonfire-ml-src/bonfire-server
RUN echo ' \
{ \
    "server_addr": { \
        "ip": "127.0.0.1", \
        "port": 2345 \
    }, \
    "llm_addr": { \
        "ip": "127.0.0.1", \
        "port": 8080 \
    }, \
    "llm_proto": "http", \
    "allowed_users": ["ehlkristofhenrik"], \
    "allowed_ip_addrs": ["127.0.0.1"], \
    "evaluator_cmd": "node main.js", \
    "github_api_config": { \
        "project": "thesis_demo", \
        "project_owner": "ehlkristofhenrik" \
    } \
}' >> /app/bonfire-ml-src/config.json

EXPOSE 2345

CMD /app/bonfire-ml-src/bonfire-server