#!/bin/sh

wget "https://huggingface.co/Mozilla/Llama-3.2-1B-Instruct-llamafile/resolve/main/Llama-3.2-1B-Instruct.Q6_K.llamafile"
chmod +x Llama-3.2-1B-Instruct.Q6_K.llamafile

# sudo docker build -t d-bonfire-mock-llm -f mock.Dockerfile .
sudo docker build -t d-bonfire-server -f server.Dockerfile .
sudo docker build -t d-bonfire-shell -f shell.Dockerfile .

./Llama-3.2-1B-Instruct.Q6_K.llamafile --server --system-prompt-file sys.txt --nobrowser
