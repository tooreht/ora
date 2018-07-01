defmodule Ora.TrackingTest do
  use Ora.DataCase

  alias Ora.Tracking

  describe "timelogs" do
    alias Ora.Tracking.Timelog

    @valid_attrs %{category: "some category", description: "some description", end: "2010-04-17 14:00:00.000000Z", start: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{category: "some updated category", description: "some updated description", end: "2011-05-18 15:01:01.000000Z", start: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{category: nil, description: nil, end: nil, start: nil}

    def timelog_fixture(attrs \\ %{}) do
      {:ok, timelog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracking.create_timelog()

      timelog
    end

    test "list_timelogs/0 returns all timelogs" do
      timelog = timelog_fixture()
      assert Tracking.list_timelogs() == [timelog]
    end

    test "get_timelog!/1 returns the timelog with given id" do
      timelog = timelog_fixture()
      assert Tracking.get_timelog!(timelog.id) == timelog
    end

    test "create_timelog/1 with valid data creates a timelog" do
      assert {:ok, %Timelog{} = timelog} = Tracking.create_timelog(@valid_attrs)
      assert timelog.category == "some category"
      assert timelog.description == "some description"
      assert timelog.end == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert timelog.start == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_timelog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_timelog(@invalid_attrs)
    end

    test "update_timelog/2 with valid data updates the timelog" do
      timelog = timelog_fixture()
      assert {:ok, timelog} = Tracking.update_timelog(timelog, @update_attrs)
      assert %Timelog{} = timelog
      assert timelog.category == "some updated category"
      assert timelog.description == "some updated description"
      assert timelog.end == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert timelog.start == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_timelog/2 with invalid data returns error changeset" do
      timelog = timelog_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_timelog(timelog, @invalid_attrs)
      assert timelog == Tracking.get_timelog!(timelog.id)
    end

    test "delete_timelog/1 deletes the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{}} = Tracking.delete_timelog(timelog)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_timelog!(timelog.id) end
    end

    test "change_timelog/1 returns a timelog changeset" do
      timelog = timelog_fixture()
      assert %Ecto.Changeset{} = Tracking.change_timelog(timelog)
    end
  end
end
