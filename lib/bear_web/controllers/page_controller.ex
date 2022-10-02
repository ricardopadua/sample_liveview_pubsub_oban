defmodule BearWeb.PageController do
  use BearWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
