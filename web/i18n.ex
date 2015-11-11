defmodule I18n do
  use Linguist.Vocabulary

  locale "en", [
    application: [
      title: "Redirect To"
    ],
    link: [
      created: "Successfully shortened '%{url}'",
      details: "Details"
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
