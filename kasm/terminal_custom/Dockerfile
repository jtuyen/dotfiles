FROM kasmweb/terminal:develop

USER root

ARG NVIM_VERSION=v0.11.5
ARG TREE_SITTER_VERSION=v0.25.10
ARG FD_VERSION=v10.4.2
ARG FZF_VERSION=0.67.0
ARG LAZYGIT_VERSION=v0.56.0

ENV HOME=/home/kasm-default-profile
WORKDIR $HOME

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       build-essential \
       ca-certificates \
       curl \
       git \
       gzip \
       ripgrep \
       tar \
       unzip \
       zsh \
       zsh-autosuggestions \
       zsh-syntax-highlighting \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fLO "https://github.com/sharkdp/fd/releases/download/${FD_VERSION}/fd-musl_${FD_VERSION#v}_amd64.deb" \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y "./fd-musl_${FD_VERSION#v}_amd64.deb" \
    && ln -sf /usr/bin/fd /usr/local/bin/fdfind \
    && rm -f "fd-musl_${FD_VERSION#v}_amd64.deb" \
    && rm -rf /var/lib/apt/lists/* \
    && fd --version | grep -q "fd ${FD_VERSION#v}" \
    && fdfind --version | grep -q "fd ${FD_VERSION#v}"

RUN curl -fLO "https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
    && mkdir -p /tmp/fzf-install \
    && tar -xzf "fzf-${FZF_VERSION}-linux_amd64.tar.gz" -C /tmp/fzf-install \
    && install -m 755 /tmp/fzf-install/fzf /usr/local/bin/fzf \
    && rm -rf /tmp/fzf-install "fzf-${FZF_VERSION}-linux_amd64.tar.gz" \
    && fzf --version | grep -q "^${FZF_VERSION}"

RUN curl -fLo /usr/local/bin/tree-sitter.gz \
       "https://github.com/tree-sitter/tree-sitter/releases/download/${TREE_SITTER_VERSION}/tree-sitter-linux-x64.gz" \
    && gunzip /usr/local/bin/tree-sitter.gz \
    && chmod 755 /usr/local/bin/tree-sitter \
    && tree-sitter --version

RUN curl -fLO "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" \
    && rm -rf /opt/nvim-linux-x86_64 \
    && tar -C /opt -xzf nvim-linux-x86_64.tar.gz \
    && ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim \
    && rm -f nvim-linux-x86_64.tar.gz \
    && nvim --version | head -n 1 | grep -q "NVIM ${NVIM_VERSION}"

RUN curl -fLO "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz" \
    && tar -xzf "lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz" lazygit \
    && install -m 755 lazygit /usr/local/bin/lazygit \
    && rm -f lazygit "lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz" \
    && lazygit --version | grep -q "version=${LAZYGIT_VERSION#v}"

COPY .tmux.conf $HOME/.tmux.conf

RUN grep -q "tmux-plugins/tpm" $HOME/.tmux.conf \
    && grep -q "tmux-plugins/tmux-sensible" $HOME/.tmux.conf \
    && grep -q "tmux-plugins/tmux-yank" $HOME/.tmux.conf \
    && grep -q "egel/tmux-gruvbox" $HOME/.tmux.conf \
    && mkdir -p $HOME/.tmux/plugins \
    && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm \
    && HOME=$HOME TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins \
       $HOME/.tmux/plugins/tpm/bin/install_plugins \
    && test -d $HOME/.tmux/plugins/tpm \
    && test -d $HOME/.tmux/plugins/tmux-sensible \
    && test -d $HOME/.tmux/plugins/tmux-yank \
    && test -d $HOME/.tmux/plugins/tmux-gruvbox

RUN mkdir -p $HOME/.local/share/fonts \
    && cd $HOME/.local/share/fonts \
    && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf \
    && fc-cache -f $HOME/.local/share/fonts

RUN export RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    && ZSH="$HOME/.oh-my-zsh" \
       ZSH_CUSTOM="$HOME/.oh-my-zsh/custom" \
       sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
    && mkdir -p "$HOME/.oh-my-zsh/custom/plugins" \
    && git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
    && git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" \
    && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete" \
    && sed -i 's|^export ZSH=.*|export ZSH="$HOME/.oh-my-zsh"|' "$HOME/.zshrc" \
    && sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/' "$HOME/.zshrc" \
    && sed -i '/^source \$ZSH\/oh-my-zsh.sh/i export ZSH_DISABLE_COMPFIX=true' "$HOME/.zshrc" \
    && sed -i '/^source \$ZSH\/oh-my-zsh.sh/i if [ -d "$HOME\/.oh-my-zsh" ]; then find "$HOME\/.oh-my-zsh" -type d -exec chmod 755 {} + 2>\/dev\/null || true; find "$HOME\/.oh-my-zsh" -type f -exec chmod 644 {} + 2>\/dev\/null || true; chmod 755 "$HOME" 2>\/dev\/null || true; fi' "$HOME/.zshrc"

RUN printf '\ncase "$-" in\n  *i*) exec /usr/bin/zsh -l;;\nesac\n' >> "$HOME/.bashrc"

RUN mkdir -p $HOME/.config/xfce4/terminal \
    && printf '%s\n' \
       '[Configuration]' \
       'FontUseSystem=FALSE' \
       'FontName=DroidSansM Nerd Font 21' \
       > $HOME/.config/xfce4/terminal/terminalrc

RUN git clone https://github.com/LazyVim/starter $HOME/.config/nvim \
    && rm -rf $HOME/.config/nvim/.git

COPY colorscheme.lua $HOME/.config/nvim/lua/plugins/colorscheme.lua

RUN HOME=$HOME \
       XDG_CONFIG_HOME=$HOME/.config \
       XDG_DATA_HOME=$HOME/.local/share \
       XDG_STATE_HOME=$HOME/.local/state \
       XDG_CACHE_HOME=$HOME/.cache \
       nvim --headless "+Lazy! sync" +qa \
    && tree-sitter --version \
    && rg --version \
    && fd --version \
    && fdfind --version \
    && fzf --version \
    && lazygit --version \
    && nvim --version | head -n 1

RUN chown -R 1000:1000 \
       $HOME/.local \
       $HOME/.cache \
       $HOME/.config \
       $HOME/.oh-my-zsh \
       $HOME/.tmux \
       $HOME/.zshrc \
       $HOME/.bashrc \
       $HOME/.tmux.conf \
    && find $HOME/.oh-my-zsh -type d -exec chmod 755 {} \; \
    && find $HOME/.oh-my-zsh -type f -exec chmod 644 {} \; \
    && find $HOME/.tmux -type d -exec chmod 755 {} \; \
    && chmod -R u=rwX,go=rX $HOME/.tmux \
    && chmod 644 $HOME/.tmux.conf $HOME/.zshrc $HOME/.bashrc $HOME/.config/xfce4/terminal/terminalrc \
    && chmod 755 $HOME/.tmux/plugins/tpm/tpm \
    && chmod 755 $HOME/.tmux/plugins/tpm/bin/* \
    && chmod 755 $HOME $HOME/.config $HOME/.config/xfce4 $HOME/.config/xfce4/terminal $HOME/.local $HOME/.local/share $HOME/.local/share/fonts $HOME/.cache \
    && chown 1000:0 $HOME \
    && /dockerstartup/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME

RUN mkdir -p $HOME \
    && chown -R 1000:0 $HOME

USER 1000

