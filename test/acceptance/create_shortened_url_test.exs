defmodule RedirectTo.CreateShortenedUrlTest do
  use RedirectTo.ConnCase

  import RedirectTo.HomepagePage, only: [
    visit_homepage: 0,
    shorten_url: 1,
    shortened_url_is_present?: 1,
    flash_is_present?: 2,
    follow_shortened_link_to: 1,
    view_count_for: 1,
    no_links_exist?: 0,
    error_message_shown: 1
  ]

  use Hound.Helpers
  hound_session

  test "create a shortened URL" do
    visit_homepage

    shorten_url "http://www.example.com"
    assert flash_is_present?(:info, "Successfully shortened 'http://www.example.com'")

    shorten_url "http://www.google.com"
    assert flash_is_present?(:info, "Successfully shortened 'http://www.google.com'")

    assert shortened_url_is_present?("http://www.example.com")
    assert shortened_url_is_present?("http://www.google.com")

    follow_shortened_link_to "http://www.example.com"
    assert current_url == "http://www.example.com/"

    visit_homepage

    assert view_count_for("http://www.example.com") == 1
  end

  test "create an invalid URL" do
    visit_homepage

    shorten_url ""

    assert no_links_exist?
    assert error_message_shown("should be")
  end
end
