defmodule Ora.Tracking.Timelog do
  use Ecto.Schema
  import Ecto.Changeset


  schema "timelogs" do
    field :description, :string
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :category, Ora.TimelogCategoryEnum
    belongs_to :user, Ora.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(timelog, attrs) do
    timelog
    |> cast(attrs, [:description, :start, :end, :category, :user_id])
    |> validate_required([:description, :start, :end, :category, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
