defmodule RedirectTo.CreateShortenedUrlTest do
  use RedirectTo.ConnCase

  import RedirectTo.HomepagePage, only: [visit_homepage: 0, shorten_url: 1, shortened_url_is_present?: 1, flash_is_present?: 2, follow_shortened_link_to: 1]
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
  end
end
