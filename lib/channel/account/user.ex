defmodule Channel.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Channel.Account.User


  schema "account_users" do
    field :email, :string
    field :name, :string

    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> hash_password
  end

  @spec hash_password(%Ecto.Changeset{}) :: %Ecto.Changeset{}
  defp hash_password(changeset = %Ecto.Changeset{valid?: true, changes: %{password: pass}}) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
  end
  defp hash_password(changeset), do: changeset
end
