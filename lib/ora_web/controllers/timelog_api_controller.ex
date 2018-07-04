defmodule OraWeb.TimelogApiController do
  use OraWeb, :controller

  alias Ora.Tracking
  alias Ora.Tracking.Timelog
  alias Ora.Accounts.User

  alias Ora.Repo

  def log_time_by_pin(conn, %{"pin" => pin}) do
    user = Repo.get_by(User, pin: pin_to_digits(pin))

    if user == nil do
      conn
      |> put_status(:unprocessable_entity)
      |> render("index.json", msg: "Invalid PIN")
    else
      timelog = Tracking.get_latest_timelog_by_user(user)

      case timelog do
        %Timelog{} ->
          update(timelog)
          render(conn, "index.json", msg: "Bli")
        nil ->
          o = create(user)
          render(conn, "index.json", msg: "Bla")
      end
    end
  end

  defp update(timelog) do
    Tracking.update_timelog(timelog, %{end: Timex.now})
  end

  defp create(user) do
    IO.puts user.id
    Tracking.create_timelog(%{
      description: "Maintenance",
      start: Timex.now(),
      end: Timex.from_unix(0),
      category: :work,
      user_id: user.id
    })
  end

  defp pin_to_digits(pin) do
    pin
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
  end
end
