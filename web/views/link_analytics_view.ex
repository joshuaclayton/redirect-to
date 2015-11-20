defmodule RedirectTo.LinkAnalyticsView do
  use RedirectTo.Web, :view
  alias RedirectTo.LinkAnalytics

  def analytics_for(link) do
    LinkAnalytics.generate(link)
  end
end
