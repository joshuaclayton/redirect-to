defmodule RedirectTo.Router do
  use RedirectTo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RedirectTo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :homepage
    get "/r/:slug", RedirectController, :show

    resources "/links", LinkController, only: [:index, :show, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", RedirectTo do
  #   pipe_through :api
  # end
end
