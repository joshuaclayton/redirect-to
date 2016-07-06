defmodule RedirectTo.LinkAnalyticsTest do
  use RedirectTo.ModelCase
  alias RedirectTo.LinkAnalytics

  test "generates device_breakdown aggregates based on a link's visits" do
    analytics = build_analytics(:device_name, [["smartphone", 10], ["Unknown", 5]])

    assert analytics.device_breakdown == [
      %{ name: "smartphone", count: 10, percentage: 66.7 },
      %{ name: "Unknown", count: 5, percentage: 33.3 }
    ]
  end

  test "generates os_breakdown aggregates based on a link's visits" do
    analytics = build_analytics(:os_name, [["mac", 7], ["windows", 2], ["android", 1]])

    assert analytics.os_breakdown == [
      %{ name: "mac", count: 7, percentage: 70.0 },
      %{ name: "windows", count: 2, percentage: 20.0 },
      %{ name: "android", count: 1, percentage: 10.0 }
    ]
  end

  test "generates browser_breakdown aggregates based on a link's visits" do
    analytics = build_analytics(:browser_name, [["Chrome", 6], ["Firefox", 4], ["Safari", 10]])

    assert analytics.browser_breakdown == [
      %{ name: "Safari", count: 10, percentage: 50.0 },
      %{ name: "Chrome", count: 6, percentage: 30.0 },
      %{ name: "Firefox", count: 4, percentage: 20.0 }
    ]
  end

  test "generates country_breakdown aggregates based on a link's visits" do
    analytics = build_analytics(:country_code, [["US", 6], ["MX", 4], ["GB", 10]])

    assert analytics.country_breakdown == [
      %{ name: "GB", count: 10, percentage: 50.0 },
      %{ name: "US", count: 6, percentage: 30.0 },
      %{ name: "MX", count: 4, percentage: 20.0 },
    ]
  end

  test "generates total count based on a link's visits" do
    analytics = build_analytics(:country_code, [["US", 6], ["MX", 4], ["GB", 10]])

    assert analytics.total == 20
  end

  defp build_analytics(attribute, list) do
    link = insert(:link)

    Enum.each list, fn([value, count]) ->
      attrs = %{link_id: link.id} |> Map.put(attribute, value)
      1..count
      |> Enum.each(fn(_) ->
        RedirectTo.LinkVisitPersister.persist(RedirectTo.Factory.build(:link_visit, attrs) |> Map.from_struct)
      end)
    end

    LinkAnalytics.generate link
  end
end
