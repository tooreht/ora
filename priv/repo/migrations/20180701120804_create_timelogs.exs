defmodule Ora.Repo.Migrations.CreateTimelogs do
  use Ecto.Migration
  alias Ora.TimelogCategoryEnum

  def up do
    TimelogCategoryEnum.create_type
    create table(:timelogs) do
      add :description, :string
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :category, :timelog_category
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:timelogs, [:user_id])
  end

  def down do
    drop index(:timelogs, [:user_id])
    drop table(:timelogs)
    TimelogCategoryEnum.drop_type
  end
end
