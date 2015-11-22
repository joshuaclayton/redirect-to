defmodule I18n do
  use Linguist.Vocabulary

  locale "en", [
    application: [
      title: "302 To"
    ],
    errors: [
      header: "There were errors"
    ],
    link: [
      created: "Successfully shortened '%{url}'",
      creation: "Created at %{timestamp}",
      view: "View",
      shortened_url_description: "Here's your shortened URL; click on the link and press Command+C to copy it to your clipboard.",
      analytics: [
        device_breakdown: "Device Breakdown",
        os_breakdown: "OS Breakdown",
        browser_breakdown: "Browser Breakdown",
        country_breakdown: "Country Breakdown",
        name: "Name",
        count: "Count",
      ]
    ],
    link_visits: [
      ip: "IP Address",
      user_agent: "User Agent",
      referer: "Referer",
      occurred_on: "Occurred"
    ],
    forms: [
      link: [
        long_url: [
          placeholder: "Enter your URL"
        ],
        submit: [
          create: "Shorten URL"
        ]
      ]
    ]
  ]
end
