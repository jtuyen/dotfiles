# Quick hand written instructions

TLDR; This Kasm terminal image is preloaded with quality of life tools such as `zsh`, `oh-my-zsh`, `tmux`, `nvim`, `codex`. In addition, persistent profile is enabled for `codex` to avoid re-authentication after each ephemeral session.

1. Using the provided files, build the container within the Kasm instance.
`docker build --no-cache -t kasm-terminal-custom:1.18.1`

Ensure that you see the newly built image locally.
```
docker images
```

2. Install the Terminal Workspaces through the Kasm repository (kasmweb/terminal:develop).

3. Reconfigure the Terminal Workspaces docker image setting to point to the build image. eg. kasm-terminal-custom:1.18.1

4. Create a new directory for persistent profile for Codex CLI or anything you need personally.
```
mkdir -p {HOME}/persist_codex
chown -R 1000:1000 {HOME}/persist_codex
```

5. Reconfigure the Terminal Workspaces volume mappings json configuration to persist Codex configuration.
```
```
```{
  "/home/jtuyen/persist_codex/{user_id}/{image_id}": {
    "bind": "/home/kasm-user/.codex",
    "mode": "rw",
    "uid": 1000,
    "gid": 1000,
    "required": true,
    "skip_check": false
  }
}
```
