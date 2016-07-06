defmodule RedirectTo.CreateShortenedUrlTest do
  use RedirectTo.FeatureCase

  import RedirectTo.HomepagePage

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

    visit_links
    view_link_details "http://www.example.com"

    assert view_count_for("http://www.example.com") == 1
  end

  test "create an invalid URL" do
    visit_homepage

    shorten_url "bad"

    refute shortened_url_is_present?("bad")
    assert error_message_shown(~r/should be/)
  end
end
