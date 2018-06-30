defmodule OraWeb.PageController do
  use OraWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
