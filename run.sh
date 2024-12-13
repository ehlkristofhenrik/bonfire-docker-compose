#!/bin/sh

wget "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile"
chmod +x Llama-3.2-1B-Instruct.Q6_K.llamafile

# sudo docker build -t d-bonfire-mock-llm -f mock.Dockerfile .
sudo docker build -t d-bonfire-server -f server.Dockerfile .
sudo docker build -t d-bonfire-shell -f shell.Dockerfile .

./Llama-3.2-1B-Instruct.Q6_K.llamafile --server --system-prompt-file sys.txt &

sudo docker compose up -d

export SHOULD_QUIT=0

function QUIT() {
    echo Bye!
    export SHOULD_QUIT=1
}

trap QUIT SIGINT

while [ $SHOULD_QUIT -eq 0 ]
do
    sudo docker compose attach shell
    sleep 3
done
