# herdr-auto-tab-name: refresh tab labels on cd.
# Optional companion to the event-driven plugin — gives instant updates when
# you cd inside a shell. Source this file from ~/.zshrc (see README.md).
#
# The hook invokes the plugin's `sync` action instead of renaming the tab
# itself, so a cd follows the same rules as every other event: manually
# renamed tabs are kept unless `overwrite_manual` is set in config.json.

if [[ -n "$HERDR_ENV" ]]; then
  _herdr_auto_tab_name() {
    # Subshells such as `(cd dir && make)` don't change this shell's cwd.
    (( ZSH_SUBSHELL )) && return 0
    "${HERDR_BIN_PATH:-herdr}" plugin action invoke dev-shimada.auto-tab-name.sync \
      >/dev/null 2>&1 &!
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _herdr_auto_tab_name
  _herdr_auto_tab_name
fi
