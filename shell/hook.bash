# herdr-auto-tab-name: refresh tab labels on cd.
# Optional companion to the event-driven plugin — gives instant updates when
# you cd inside a shell. Source this file from ~/.bashrc (see README.md).
#
# The hook invokes the plugin's `sync` action instead of renaming the tab
# itself, so a cd follows the same rules as every other event: manually
# renamed tabs are kept unless `overwrite_manual` is set in config.json.

if [[ -n "$HERDR_ENV" ]]; then
  _herdr_auto_tab_name() {
    if [[ "$PWD" != "$_herdr_last_pwd" ]]; then
      _herdr_last_pwd="$PWD"
      ("${HERDR_BIN_PATH:-herdr}" plugin action invoke dev-shimada.auto-tab-name.sync \
        >/dev/null 2>&1 &)
    fi
  }
  case ";$PROMPT_COMMAND;" in
    *";_herdr_auto_tab_name;"*) ;;
    *) PROMPT_COMMAND="_herdr_auto_tab_name${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
  esac
  _herdr_auto_tab_name
fi
