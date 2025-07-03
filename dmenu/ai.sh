#!/bin/bash
set -euo pipefail

MODEL_PORT=11434
CONTAINER_NAME=deepseek
CHATBOX_PATH=$HOME/aur/chatbox-bin/startup.sh

# Function to wait for Ollama server to be ready
wait_for_ollama() {
    echo "⏳ Waiting for Ollama to respond on port $MODEL_PORT..."
    until curl -s "http://localhost:$MODEL_PORT/api/tags" > /dev/null; do
        sleep 1
    done
    echo "✅ Ollama is ready."
}

# Start the container
echo "📦 Starting DeepSeek container..."
docker start "$CONTAINER_NAME" >/dev/null

# Wait until the Ollama server is up
wait_for_ollama

# Launch Chatbox
echo "🚀 Launching Chatbox..."
$CHATBOX_PATH &

# Optional: wait for Chatbox to exit
wait %1

# Stop the container afterward
echo "🛑 Stopping DeepSeek container..."
docker stop "$CONTAINER_NAME"

