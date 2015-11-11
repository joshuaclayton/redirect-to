defmodule RedirectTo.UserAgentTest do
  use ExUnit.Case

  alias RedirectTo.UserAgent

  test "browser_name handles unknowns" do
    assert UserAgent.browser_name("bogus") == "Unknown"
  end

  test "browser_name handles Safari on iPad" do
    assert UserAgent.browser_name(safari_ipad) == "Mobile Safari"
  end

  test "os_name handles Safari on iPad" do
    assert UserAgent.os_name(safari_ipad) == "ios"
  end

  test "os_name handles unknowns" do
    assert UserAgent.os_name("bogus") == "Unknown"
  end

  test "device_name handles Safari on iPad" do
    assert UserAgent.device_name(safari_ipad) == "iPad"
  end

  test "device_name handles unknowns" do
    assert UserAgent.device_name("bogus") == "Unknown"
  end

  defp safari_ipad do
    "Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B554a Safari/9537.53"
  end
end
