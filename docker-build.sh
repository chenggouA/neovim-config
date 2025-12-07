#!/bin/bash
# ============================================================================
# Neovim Docker Image Build Script - Multi-Architecture Support
# ============================================================================

set -e

IMAGE_NAME="neovim-dev"
IMAGE_TAG="latest"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

# Detect platform
PLATFORM=${1:-"linux/$(uname -m)"}

echo "============================================="
echo "Building Neovim Development Environment"
echo "Image: ${FULL_IMAGE_NAME}"
echo "Platform: ${PLATFORM}"
echo "============================================="

# Build the Docker image with platform specification
docker build \
    --platform "${PLATFORM}" \
    --build-arg USERNAME=chenggou \
    --build-arg USER_UID=1001 \
    --build-arg USER_GID=1001 \
    -t "${FULL_IMAGE_NAME}" \
    .

echo ""
echo "============================================="
echo "Build completed successfully!"
echo "============================================="
echo ""
echo "To run the container:"
echo "  docker run -it --rm ${FULL_IMAGE_NAME}"
echo ""
echo "To run with volume mount (persist data):"
echo "  docker run -it --rm -v \$(pwd)/workspace:/home/chenggou/workspace ${FULL_IMAGE_NAME}"
echo ""
echo "To build for specific platform:"
echo "  ./docker-build.sh linux/amd64     # For x86_64/Intel"
echo "  ./docker-build.sh linux/arm64     # For ARM64/Apple Silicon"
echo ""
echo "To build multi-platform image (requires buildx):"
echo "  docker buildx build --platform linux/amd64,linux/arm64 -t ${FULL_IMAGE_NAME} ."
echo ""