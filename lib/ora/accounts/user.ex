defmodule Ora.Accounts.User do
  use Ecto.Schema
  use Coherence.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :email, :string
    field :pin, {:array, :integer}
    field :is_admin, :boolean, default: false
    field :is_superuser, :boolean, default: false
    has_many :timelogs, Ora.Tracking.Timelog

    coherence_schema()
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :pin, :is_admin, :is_superuser] ++ coherence_fields())
    |> validate_required([:name, :email, :pin, :is_admin, :is_superuser])
    |> validate_coherence(attrs)
  end
end
