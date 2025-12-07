#!/bin/bash
# ============================================================================
# Neovim Development Environment Setup Script
# 可在任何 Ubuntu/Debian 系统上安装 Neovim + 配置 + 工具
# ============================================================================

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 配置参数
NVIM_VERSION="v0.11.5"
STYLUA_VERSION="v2.3.1"
NVIM_LISTEN_PORT="${NVIM_LISTEN_PORT:-6666}"
START_SERVER="${1:-no}"  # 是否启动服务器：yes/no

echo_info() {
    echo -e "${GREEN}=> $1${NC}"
}

echo_warn() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

echo_error() {
    echo -e "${RED}✗ $1${NC}"
}

# ============================================================================
# 1. 检测架构
# ============================================================================
echo_info "检测系统架构..."
ARCH=$(uname -m)
case "$ARCH" in
    x86_64|amd64)
        NVIM_ARCH="x86_64"
        STYLUA_ARCH="x86_64"
        ;;
    aarch64|arm64)
        NVIM_ARCH="arm64"
        STYLUA_ARCH="aarch64"
        ;;
    *)
        echo_error "不支持的架构: $ARCH"
        exit 1
        ;;
esac
echo_info "架构: $ARCH (Neovim: $NVIM_ARCH, Stylua: $STYLUA_ARCH)"

# ============================================================================
# 2. 更新包列表并安装基础依赖
# ============================================================================
echo_info "更新 apt 包列表..."
sudo apt-get update

echo_info "安装基础依赖..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    tar \
    gzip \
    ca-certificates \
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    ripgrep \
    fd-find \
    sudo

# ============================================================================
# 3. 安装 Python 环境和格式化工具
# ============================================================================
echo_info "安装 Python 环境..."
sudo apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

echo_info "安装 Python 格式化工具 (ruff)..."
pip3 install --user --break-system-packages ruff || \
    pip3 install --user ruff

# ============================================================================
# 4. 安装 Node.js 和格式化工具
# ============================================================================
echo_info "检查 Node.js..."
if ! command -v node &> /dev/null; then
    echo_info "安装 Node.js LTS..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
else
    echo_info "Node.js 已安装: $(node --version)"
fi

echo_info "安装 Node.js 格式化工具..."
sudo npm install -g prettier neovim

# ============================================================================
# 5. 安装 Neovim (最新版本)
# ============================================================================
echo_info "安装 Neovim ${NVIM_VERSION}..."

# 下载 Neovim
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz"
echo_info "下载: $NVIM_URL"
curl -fsSL "$NVIM_URL" -o /tmp/nvim.tar.gz

# 解压并安装
tar -xzf /tmp/nvim.tar.gz -C /tmp
sudo rm -rf /opt/nvim
sudo mv "/tmp/nvim-linux-${NVIM_ARCH}" /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
rm /tmp/nvim.tar.gz

echo_info "Neovim 安装完成: $(nvim --version | head -n1)"

# ============================================================================
# 6. 安装 Stylua (Lua 格式化工具)
# ============================================================================
echo_info "安装 Stylua ${STYLUA_VERSION}..."

STYLUA_URL="https://github.com/JohnnyMorganz/StyLua/releases/download/${STYLUA_VERSION}/stylua-linux-${STYLUA_ARCH}.zip"
echo_info "下载: $STYLUA_URL"
wget -qO /tmp/stylua.zip "$STYLUA_URL"
unzip -o /tmp/stylua.zip -d /tmp
sudo mv /tmp/stylua /usr/local/bin/stylua
sudo chmod +x /usr/local/bin/stylua
rm /tmp/stylua.zip

echo_info "Stylua 安装完成: $(stylua --version)"

# ============================================================================
# 7. 安装 jq (JSON 格式化工具)
# ============================================================================
echo_info "安装 jq..."
sudo apt-get install -y jq

# ============================================================================
# 8. 检查 Neovim 配置目录
# ============================================================================
NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    echo_error "Neovim 配置目录不存在: $NVIM_CONFIG_DIR"
    echo_warn "请确保配置已通过卷挂载或其他方式提供"
    echo_info "跳过插件安装步骤..."
    SKIP_PLUGINS=true
else
    echo_info "找到 Neovim 配置目录: $NVIM_CONFIG_DIR"
    SKIP_PLUGINS=false
fi

# ============================================================================
# 9. 安装/同步 Neovim 插件
# ============================================================================
if [ "$SKIP_PLUGINS" = "false" ]; then
    echo_info "同步 Neovim 插件 (Lazy.nvim)..."
    echo_info "第一次同步..."
    nvim --headless "+Lazy! sync" +qa || true

    echo_info "第二次同步 (确保所有插件加载)..."
    nvim --headless "+Lazy! sync" +qa || true

    # ============================================================================
    # 10. 安装 LSP 服务器 (Mason)
    # ============================================================================
    echo_info "安装 LSP 服务器 (pyright, clangd)..."
    nvim --headless "+MasonInstall pyright clangd" +qa || true
else
    echo_warn "跳过插件安装（配置目录未找到）"
fi

# ============================================================================
# 12. 启动 Neovim Server (可选)
# ============================================================================
if [ "$START_SERVER" = "yes" ] || [ "$START_SERVER" = "server" ]; then
    echo_info "启动 Neovim Server (监听 0.0.0.0:${NVIM_LISTEN_PORT})..."
    echo_info "连接命令: neovide --server localhost:${NVIM_LISTEN_PORT}"

    # 杀死已有的服务器进程
    pkill -f "nvim.*listen.*${NVIM_LISTEN_PORT}" || true

    # 后台启动服务器
    nohup nvim --headless --listen "0.0.0.0:${NVIM_LISTEN_PORT}" \
        > /tmp/nvim-server.log 2>&1 &

    echo_info "服务器已启动 (PID: $!)"
    echo_info "日志: /tmp/nvim-server.log"
fi

# ============================================================================
# 完成
# ============================================================================
echo ""
echo_info "============================================="
echo_info "Neovim 开发环境安装完成！"
echo_info "============================================="
echo ""
echo_info "已安装的工具:"
echo "  - Neovim: $(nvim --version | head -n1)"
echo "  - Node.js: $(node --version)"
echo "  - Python: $(python3 --version)"
echo "  - Ruff: $(ruff --version 2>/dev/null || echo 'installed')"
echo "  - Stylua: $(stylua --version)"
echo "  - Prettier: $(prettier --version)"
echo "  - jq: $(jq --version)"
echo ""
echo_info "使用方法:"
echo "  直接运行: nvim"
echo "  启动服务器: $0 server"
echo "  连接服务器: neovide --server localhost:${NVIM_LISTEN_PORT}"
echo ""
if [ "$SKIP_PLUGINS" = "true" ]; then
    echo_warn "提示: 配置目录未找到，插件未安装"
    echo_warn "请挂载配置目录到 ~/.config/nvim 后再运行此脚本"
fi