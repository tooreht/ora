defmodule OraWeb.Router do
  use OraWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  pipeline :api do
    plug Corsica, origins: "*"
    plug :accepts, ["json"]
  end

  scope "/", OraWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", OraWeb do
    pipe_through :protected
    # Add protected routes below
    resources "/users", UserController
    resources "/timelogs", TimelogController
  end

  # Other scopes may use custom stacks.
  scope "/api", OraWeb do
    pipe_through :api

    get "/timelogs/:pin", TimelogApiController, :log_time_by_pin
  end
end
