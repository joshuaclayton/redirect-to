RedirectTo.Repo.delete_all RedirectTo.LinkVisit
RedirectTo.Repo.delete_all RedirectTo.Link

1..52 |> Enum.each fn(_) ->
  RedirectTo.LinkCreator.create %{long_url: "http://joshuaclayton.me"}
end
