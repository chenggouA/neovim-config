#!/bin/bash
# ============================================================================
# Neovim Docker Image Build Script - Multi-Architecture Support
#
# 构建说明：
# - 使用 setup-nvim.sh 脚本进行核心安装（Neovim、Node.js、工具等）
# - 自动检测架构（x86_64/arm64）并下载对应版本
# - 以普通用户 chenggou 运行，脚本内部使用 sudo
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
echo "Build Method: setup-nvim.sh script"
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