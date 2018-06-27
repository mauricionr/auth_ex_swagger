defmodule AuthExWeb.Router do
  use AuthExWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug AuthEx.Auth.Pipeline
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Maybe logged in scope
  scope "/", AuthExWeb do
    pipe_through [:browser, :auth]
    get "/", PageController, :index
    post "/", PageController, :login
    post "/logout", PageController, :logout
  end

  scope "/api", AuthExWeb do
    pipe_through [:api]
    resources "/images", ImageController, except: [:new, :edit]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :auth_ex, swagger_file: "swagger.json"
  end

  # Definitely logged in scope
  scope "/", AuthExWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/secret", PageController, :secret
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "AuthEx"
      }
    }
  end
end
