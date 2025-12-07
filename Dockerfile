# ============================================================================
# Neovim Development Environment - Full Config with Plugins
# ============================================================================
FROM ubuntu:24.04

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TZ=Asia/Shanghai

# ============================================================================
# Stage 1: System packages and dependencies
# ============================================================================
RUN apt-get update && apt-get install -y \
    # Basic tools
    curl \
    wget \
    git \
    unzip \
    tar \
    gzip \
    ca-certificates \
    build-essential \
    # Neovim dependencies
    software-properties-common \
    # Compilation tools (for tree-sitter)
    gcc \
    g++ \
    make \
    cmake \
    # Python environment
    python3 \
    python3-pip \
    python3-venv \
    # Node.js dependency
    npm \
    # Other tools
    ripgrep \
    fd-find \
    locales \
    tzdata \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone and locale
RUN locale-gen en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# ============================================================================
# Stage 2: Install latest Neovim (0.11+) - Auto-detect architecture
# ============================================================================
ARG NVIM_VERSION=v0.11.5
ARG TARGETARCH

RUN ARCH=$(uname -m) && \
    case "${TARGETARCH:-$ARCH}" in \
        amd64|x86_64) NVIM_ARCH="x86_64" ;; \
        arm64|aarch64) NVIM_ARCH="arm64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH:-$ARCH}"; exit 1 ;; \
    esac && \
    echo "Installing Neovim ${NVIM_VERSION} for ${NVIM_ARCH}" && \
    curl -fsSL "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" -o nvim.tar.gz && \
    tar -xzf nvim.tar.gz && \
    mv "nvim-linux-${NVIM_ARCH}" /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim.tar.gz

# ============================================================================
# Stage 3: Install Node.js LTS (for LSP and formatters)
# ============================================================================
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# ============================================================================
# Stage 4: Install formatters and tools
# ============================================================================
# Python formatters
RUN pip3 install --no-cache-dir --break-system-packages ruff

# Node.js formatters
RUN npm install -g prettier neovim

# Stylua for Lua formatting - Auto-detect architecture
ARG STYLUA_VERSION=v2.3.1
ARG TARGETARCH

RUN ARCH=$(uname -m) && \
    case "${TARGETARCH:-$ARCH}" in \
        amd64|x86_64) STYLUA_ARCH="x86_64" ;; \
        arm64|aarch64) STYLUA_ARCH="aarch64" ;; \
        *) echo "Unsupported architecture for stylua: ${TARGETARCH:-$ARCH}"; exit 1 ;; \
    esac && \
    echo "Installing Stylua ${STYLUA_VERSION} for linux-${STYLUA_ARCH}" && \
    wget -qO /tmp/stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/${STYLUA_VERSION}/stylua-linux-${STYLUA_ARCH}.zip" && \
    unzip /tmp/stylua.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/stylua && \
    rm /tmp/stylua.zip

# jq for JSON formatting
RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*

# ============================================================================
# Stage 5: Create non-root user
# ============================================================================
ARG USERNAME=chenggou
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to regular user
USER $USERNAME
WORKDIR /home/$USERNAME

# ============================================================================
# Stage 6: Copy Neovim configuration
# ============================================================================
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/.config/nvim/

# ============================================================================
# Stage 7: Pre-install Neovim plugins and LSP
# ============================================================================
# Auto-install lazy.nvim and all plugins
RUN nvim --headless "+Lazy! sync" +qa || true

# Run again to ensure all plugins are loaded correctly
RUN nvim --headless "+Lazy! sync" +qa || true

# Trigger Mason to install LSP servers (pyright, clangd)
RUN nvim --headless "+MasonInstall pyright clangd" +qa || true

# ============================================================================
# Stage 8: Install additional development tools
# ============================================================================
USER root
RUN apt-get update && apt-get install -y \
    # C/C++ development
    clang \
    clang-tidy \
    lldb \
    # Python development
    python3-dev \
    # Git enhancements
    git-lfs \
    tig \
    # Terminal enhancements
    tmux \
    htop \
    && rm -rf /var/lib/apt/lists/*

# ============================================================================
# Final configuration
# ============================================================================
USER $USERNAME
WORKDIR /home/$USERNAME

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD nvim --version || exit 1

# Set default shell
ENV SHELL=/bin/bash

# Default command
CMD ["/bin/bash"]