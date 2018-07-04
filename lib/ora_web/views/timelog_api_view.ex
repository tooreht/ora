defmodule OraWeb.TimelogApiView do
  use OraWeb, :view

  def render("index.json", %{msg: msg}) do
    %{data: %{msg: msg}}
  end
end