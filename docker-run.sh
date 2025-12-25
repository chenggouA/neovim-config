#!/bin/bash
# ============================================================================
# Run Neovim Docker Container with Remote Access
#
# Usage:
#   ./docker-run.sh          # Normal mode (interactive bash)
#   ./docker-run.sh server   # Server mode (auto-start nvim server)
#
# Features:
# - Runs as user 'chenggou' inside container
# - Maps Neovim server port 6666 for remote access
# - Mounts ./workspace to /home/chenggou/workspace
# ============================================================================

set -e

IMAGE_NAME="neovim-dev:latest"
CONTAINER_NAME="neovim-dev-container"
NVIM_LISTEN_PORT=6666
MODE=${1:-normal}

echo "============================================="
echo "Starting Neovim Development Container"
echo "Container: ${CONTAINER_NAME}"
echo "Neovim Server: localhost:${NVIM_LISTEN_PORT}"
echo "Mode: ${MODE}"
echo "============================================="

# Remove existing container if it exists
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true

if [ "$MODE" = "server" ]; then
    # Server mode: Start Neovim server automatically
    echo ""
    echo "Starting Neovim as server..."
    echo "Connect from host with:"
    echo "  neovide --server localhost:${NVIM_LISTEN_PORT}"
    echo ""

    docker run -it --rm \
        --name "${CONTAINER_NAME}" \
        -p "${NVIM_LISTEN_PORT}:${NVIM_LISTEN_PORT}" \
        -v "$(pwd)/workspace:/home/chenggou/workspace" \
        "${IMAGE_NAME}" \
        nvim --listen "0.0.0.0:${NVIM_LISTEN_PORT}" --headless
else
    # Normal mode: Interactive bash
    docker run -it --rm \
        --name "${CONTAINER_NAME}" \
        -p "${NVIM_LISTEN_PORT}:${NVIM_LISTEN_PORT}" \
        -v "$(pwd)/workspace:/home/chenggou/workspace" \
        "${IMAGE_NAME}" \
        bash
fi

echo ""
echo "Container stopped."