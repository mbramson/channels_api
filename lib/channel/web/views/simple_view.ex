defmodule Channel.Web.SimpleView do
  use Channel.Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email}
  end
end
