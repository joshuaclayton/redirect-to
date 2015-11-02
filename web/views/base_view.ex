defmodule RedirectTo.BaseView do
  def t(_conn, string, bindings \\ []) do
    I18n.t!("en", string, bindings)
  end
end
