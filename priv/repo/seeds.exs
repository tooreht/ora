# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ora.Repo.insert!(%Ora.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Ora.Repo.delete_all Ora.Accounts.User

Ora.Accounts.User.changeset(%Ora.Accounts.User{}, %{name: "Armin Admin", email: "admin@ora.local", password: "secret", password_confirmation: "secret", pin: [1,2,3,4]})
|> Ora.Repo.insert!
