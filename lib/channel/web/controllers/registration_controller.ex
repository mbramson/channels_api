defmodule Channel.Web.RegistrationController do
  use Channel.Web, :controller

  alias Channel.Account
  alias Channel.Account.User

  action_fallback Channel.Web.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)

      conn
      |> put_status(:created)
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> render("registration.json", user: user, jwt: jwt)
    end
  end
end
