defmodule RedirectTo.LinkVisitViewTest do
  use RedirectTo.ConnCase, async: true
  alias RedirectTo.LinkVisit

  test "referer_host handles valid referers" do
    link_visit = %LinkVisit{referer: "http://www.google.com"}
    assert RedirectTo.LinkVisitView.referer_host(link_visit) == "www.google.com"
  end

  test "referer_host handles empty referers" do
    link_visit = %LinkVisit{}
    assert RedirectTo.LinkVisitView.referer_host(link_visit) == ""
  end

  test "referer_host handles bogus referers" do
    link_visit = %LinkVisit{referer: "blow it up"}
    assert RedirectTo.LinkVisitView.referer_host(link_visit) == ""
  end
end
