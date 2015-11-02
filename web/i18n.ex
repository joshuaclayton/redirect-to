defmodule I18n do
  use Linguist.Vocabulary

  locale "en", [
    application: [
      title: "302.to"
    ],
    link: [
      created: "Successfully shortened '%{url}'"
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
