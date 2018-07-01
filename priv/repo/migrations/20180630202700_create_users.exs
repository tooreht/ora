defmodule Ora.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :pin, {:array, :integer}
      add :is_admin, :boolean, default: false, null: false
      add :is_superuser, :boolean, default: false, null: false

      timestamps()
    end

  end
end
