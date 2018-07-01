defmodule OraWeb.TimelogControllerTest do
  use OraWeb.ConnCase

  alias Ora.Tracking

  @create_attrs %{category: "some category", description: "some description", end: "2010-04-17 14:00:00.000000Z", start: "2010-04-17 14:00:00.000000Z"}
  @update_attrs %{category: "some updated category", description: "some updated description", end: "2011-05-18 15:01:01.000000Z", start: "2011-05-18 15:01:01.000000Z"}
  @invalid_attrs %{category: nil, description: nil, end: nil, start: nil}

  def fixture(:timelog) do
    {:ok, timelog} = Tracking.create_timelog(@create_attrs)
    timelog
  end

  describe "index" do
    test "lists all timelogs", %{conn: conn} do
      conn = get conn, timelog_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Timelogs"
    end
  end

  describe "new timelog" do
    test "renders form", %{conn: conn} do
      conn = get conn, timelog_path(conn, :new)
      assert html_response(conn, 200) =~ "New Timelog"
    end
  end

  describe "create timelog" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, timelog_path(conn, :create), timelog: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == timelog_path(conn, :show, id)

      conn = get conn, timelog_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Timelog"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, timelog_path(conn, :create), timelog: @invalid_attrs
      assert html_response(conn, 200) =~ "New Timelog"
    end
  end

  describe "edit timelog" do
    setup [:create_timelog]

    test "renders form for editing chosen timelog", %{conn: conn, timelog: timelog} do
      conn = get conn, timelog_path(conn, :edit, timelog)
      assert html_response(conn, 200) =~ "Edit Timelog"
    end
  end

  describe "update timelog" do
    setup [:create_timelog]

    test "redirects when data is valid", %{conn: conn, timelog: timelog} do
      conn = put conn, timelog_path(conn, :update, timelog), timelog: @update_attrs
      assert redirected_to(conn) == timelog_path(conn, :show, timelog)

      conn = get conn, timelog_path(conn, :show, timelog)
      assert html_response(conn, 200) =~ "some updated category"
    end

    test "renders errors when data is invalid", %{conn: conn, timelog: timelog} do
      conn = put conn, timelog_path(conn, :update, timelog), timelog: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Timelog"
    end
  end

  describe "delete timelog" do
    setup [:create_timelog]

    test "deletes chosen timelog", %{conn: conn, timelog: timelog} do
      conn = delete conn, timelog_path(conn, :delete, timelog)
      assert redirected_to(conn) == timelog_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, timelog_path(conn, :show, timelog)
      end
    end
  end

  defp create_timelog(_) do
    timelog = fixture(:timelog)
    {:ok, timelog: timelog}
  end
end
