{
  configDir,
  pkgs,
  lib,
  ...
}: let
  withPluginConfig = pluginList: let
    addConfig = plugin: let
      fileName = lib.toLower plugin.pname;
      filePath = "${configDir}/nvim/lua/${fileName}.lua";
      pluginConfig =
        if builtins.pathExists filePath
        then builtins.readFile filePath
        else "";
    in {
      plugin = plugin;
      type = "lua";
      config = pluginConfig;
    };
  in
    builtins.map addConfig pluginList;

  lsps = with pkgs; [
    astro-language-server
    clang-tools
    crystalline
    gopls
    java-language-server
    nil
    pyright
    rust-analyzer
    lua-language-server
    tailwindcss-language-server
    terraform-lsp
    tinymist

    nodePackages.bash-language-server
    nodePackages.eslint
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
  ];
in {
  home.packages = with pkgs;
    [
      alejandra
      go
      shellcheck
      typst
      typstyle
    ]
    ++ lsps;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = withPluginConfig (with pkgs.vimPlugins; [
      lspkind-nvim
      nvim-lspconfig
      nvim-web-devicons
      plenary-nvim
      render-markdown-nvim
      rainbow-delimiters-nvim
      luasnip
      lsp_lines-nvim
      nvim-lint
      Navigator-nvim
      telescope-nvim
      luasnip
      noice-nvim
      nvim-cmp
      pkgs.unstable.vimPlugins.nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-notify
      dashboard-nvim
      lualine-nvim
      tokyonight-nvim

      cmp-buffer
      cmp-cmdline
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter
    ]);

    extraLuaPackages = ps: [ps.lua-lsp];

    extraLuaConfig = builtins.readFile "${configDir}/nvim/init.lua";
  };
}
