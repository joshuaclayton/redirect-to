defmodule RedirectTo.HomepageTest do
  use RedirectTo.ConnCase

  # Import Hound helpers
  alias RedirectTo.HomepagePage
  use Hound.Helpers

  # Start a Hound session
  hound_session

  test "GET /" do
    HomepagePage.visit
    assert HomepagePage.header_is_present?
  end
end

defmodule RedirectTo.HomepagePage do
  use Hound.Helpers

  def visit do
    navigate_to "/"
  end

  def header_is_present? do
    header_text == I18n.t!("en", "application.title")
  end

  defp header_text do
    find_element(:css, "header[data-role='primary']")
    |> visible_text
  end
end
