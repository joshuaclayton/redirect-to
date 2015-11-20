defmodule RedirectTo.LayoutView do
  use RedirectTo.Web, :view

  def split_to_spans(text) do
    text
    |> String.split(" ")
    |> Enum.map(fn(split) ->
      "<span>#{split}</span>"
    end)
    |> Enum.join(" ")
  end

  def scripts(conn, assigns) do
    [
      raw(default_scripts(conn)),
      raw(render_existing(view_module(conn), "scripts." <> view_template(conn), assigns))
    ]
  end

  def default_scripts(conn) do
    ~s"""
    <script src="#{static_path(conn, "/js/app.js")}"></script>
    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
    """
  end
end
