defmodule RedirectTo.HomepageTest do
  use RedirectTo.FeatureCase

  import RedirectTo.HomepagePage, only: [visit_homepage: 0, header_is_present?: 0]

  test "homepage works" do
    visit_homepage
    assert header_is_present?
  end
end
