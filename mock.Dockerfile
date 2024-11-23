FROM oven/bun

WORKDIR /app

EXPOSE 8080

RUN apt update
RUN apt install git curl -y

RUN git clone https://github.com/ehlkristofhenrik/bonfire-mock-llm

WORKDIR /app/bonfire-mock-llm

CMD bun run index.ts