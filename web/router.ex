defmodule Pluto.Router do
  use Pluto.Web, :router

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

  scope "/", Pluto do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Pluto do
    pipe_through :api
    resources "/tickets", TicketController, except: [:new, :edit] do
      resources "/comments", CommentController, except: [:new, :edit]
    end
    resources "/uploads/:type/:type_id", UploadController, except: [:new, :edit]
  end
end
