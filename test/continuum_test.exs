defmodule ContinuumTest do
  use Continuum.TestCase
  import Ecto.Query
  doctest Continuum

  alias Continuum.Repo
  alias Continuum.Weather
  alias Continuum.Changeset

  test "creations are tracked" do
    insert_weather
    assert count_changesets == 1
  end

  test "updates are tracked" do
    weather = insert_weather

    weather
    |> Weather.changeset(%{"city" => "Las Vegas", "temp_lo" => 60, "temp_hi" => 78})
    |> Repo.update!

    assert count_changesets == 2
  end

  test "warping to a specific point in time" do
    weather = insert_weather

    latest = weather
    |> Weather.changeset(%{"city" => "Las Vegas"})
    |> Repo.update!
    |> Weather.changeset(%{"city" => "London"})
    |> Repo.update!

    Ecto.Adapters.SQL.query(Repo, "UPDATE changesets SET inserted_at = inserted_at + INTERVAL '1h' * id", []) # HACK : ensure time delta between changesets

    first_update = Repo.one(
      from c in Changeset,
           select: min(c.inserted_at),
           where: c.operation == "update"
    )

    warped = Continuum.warp(latest, Repo, to: first_update)
    assert warped.city == "Las Vegas"
    assert warped.temp_lo == 52
  end

  defp count_changesets do
    Repo.one(from c in Changeset, select: count(c.id))
  end

  defp insert_weather do
    {:ok, date} = Ecto.Date.cast("2015-10-09")
    Repo.insert!(%Weather{
      city:     "Denver",
      date:     date,
      temp_lo:  52,
      temp_hi:  72,
      prcp:     0.0
    })
  end
end
