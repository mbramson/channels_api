defmodule Channel.Web.Router do
  use Channel.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureResource
  end

  scope "/api", Channel.Web do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create
      post "/sessions", SessionController, :create
    end

    scope "/v1" do
      pipe_through :api_auth
      
      get "/current_user", SimpleController, :show
    end
  end
end
