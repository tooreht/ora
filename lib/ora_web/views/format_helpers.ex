defmodule OraWeb.FormatHelpers do
  use Timex

  def date_format(date), do: date_format date, "{RFC1123}"

  def date_format(date = %DateTime{}, format_string) do
    date
    |> date_formatter(format_string)
  end

  def date_format(date = %Date{}, format_string) do
    << date <> "T00:00:00Z" >>
    |> date_formatter(format_string)
  end

  def date_format(_, _format), do: ""

  defp date_formatter(date, format_string) do
    date
    |> Timex.format!(format_string)
  end
end
