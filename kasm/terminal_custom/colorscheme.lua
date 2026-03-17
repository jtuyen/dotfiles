return {
  -- Add the theme plugin
  { "ellisonleao/gruvbox.nvim" },
  -- Configure LazyVim to load it
  { "LazyVim/LazyVim", opts = {
    colorscheme = "gruvbox",
    background = "dark",
  } },
}
