defmodule RedirectTo.Factory do
  use ExMachina.Ecto, repo: RedirectTo.Repo

  def factory(:link) do
    %RedirectTo.Link{
      long_url: "http://www.example.com",
      slug: sequence(:slug, &RedirectTo.TokenGenerator.generate(&1))
    }
  end

  def factory(:link_visit) do
    %RedirectTo.LinkVisit{
      device_name: "Unknown",
      browser_name: "Chrome",
      os_name: "mac",
      ip: "127.0.0.1",
      referer: "twitter.com",
      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36",
      link: create(:link),
    }
  end
end
