defmodule RedirectTo.HomepagePage do
  use Hound.Helpers

  def visit_homepage do
    navigate_to "/"
  end

  def header_is_present? do
    header_text == I18n.t!("en", "application.title")
  end

  def shorten_url(url) do
    fill_field({:id, "link_long_url"}, url)
    submit_element({:css, "input[type='submit']"})
  end

  def shortened_url_is_present?(url) do
    long_urls
    |> Enum.member? url
  end

  def follow_shortened_link_to(url) do
    find_element(:link_text, url)
    |> click
  end

  def flash_is_present?(type, message) do
    flash_for_type(type) == message
  end

  defp header_text do
    find_element(:css, "header[data-role='primary']")
    |> visible_text
  end

  defp long_urls do
    find_all_elements(:css, ".links li")
    |> Enum.map &visible_text/1
  end

  defp flash_for_type(type) do
    find_element(:css, ".alert-#{type}")
    |> visible_text
  end
end
