defmodule RedirectTo.HomepagePage do
  use Hound.Helpers
  import Hound.Matchers.Text, only: [visible_on_page?: 1]

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
    link_on_page(url)
  end

  def follow_shortened_link_to(url) do
    find_element(:link_text, url)
    |> click
  end

  def flash_is_present?(type, message) do
    flash_for_type(type) == message
  end

  def view_count_for(url) do
    link_on_page(url)
    |> find_within_element(:class, "view-count")
    |> visible_text
    |> String.to_integer
  end

  def error_message_shown(message) do
    visible_on_page?(message)
  end

  defp header_text do
    find_element(:css, "header[data-role='primary']")
    |> visible_text
  end

  defp link_on_page(url) do
    all_links
    |> Enum.find fn(element) ->
      (element |> visible_text) =~ ~r/#{url}/
    end
  end

  defp flash_for_type(type) do
    find_element(:css, ".alert-#{type}")
    |> visible_text
  end

  defp all_links do
    find_all_elements(:css, ".links li")
  end
end
