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
# Stage 1: Install basic dependencies and sudo
# ============================================================================
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    locales \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Configure timezone and locale
RUN locale-gen en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# ============================================================================
# Stage 2: Create non-root user with sudo privileges
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
# Stage 3: Copy and run setup script
# ============================================================================
COPY --chown=$USERNAME:$USERNAME setup-nvim.sh /home/$USERNAME/

# Run setup script (will use sudo internally)
RUN bash /home/$USERNAME/setup-nvim.sh no

# ============================================================================
# Stage 4: Copy Neovim configuration
# ============================================================================
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/.config/nvim/

# ============================================================================
# Stage 5: Install Neovim plugins and LSP servers
# ============================================================================
# Auto-install lazy.nvim and all plugins (treesitter parsers will install on first use)
RUN nvim --headless "+Lazy! sync" +qa || true

# Run again to ensure all plugins are loaded correctly
RUN nvim --headless "+Lazy! sync" +qa || true

# Trigger Mason to install LSP servers (pyright only; clangd installed via apt in setup-nvim.sh)
RUN nvim --headless "+MasonInstall pyright" +qa || true

# ============================================================================
# Stage 6: Install additional development tools
# ============================================================================
USER root
RUN apt-get update && apt-get install -y \
    # C/C++ development
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
