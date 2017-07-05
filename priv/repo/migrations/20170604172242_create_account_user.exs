defmodule Channel.Repo.Migrations.CreateChannel.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:account_users, [:email])
  end
end
