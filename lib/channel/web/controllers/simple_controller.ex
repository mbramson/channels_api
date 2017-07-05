defmodule Channel.Web.SimpleController do
  use Channel.Web, :controller

  alias Channel.Account
  alias Channel.Account.User
  alias Channel.Account.Session

  action_fallback Channel.Web.FallbackController

  plug :scrub_params, "session" when action in [:create]

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn
    |> put_status(:ok)
    |> render("user.json", user: user)
  end
end
