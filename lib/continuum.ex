defmodule Continuum do
  alias Continuum.Changeset
  import Ecto.Query

  defmacro __using__(_opts) do
    quote do
      use Ecto.Model.Callbacks

      after_insert Continuum, :after_insert
      after_update Continuum, :after_update
      after_delete Continuum, :after_delete
    end
  end

  def after_insert(changeset) do
    handle_operation("insert", changeset)
    changeset
  end

  def after_update(changeset) do
    handle_operation("update", changeset)
    changeset
  end

  def after_delete(changeset) do
    handle_operation("delete", changeset)
    changeset
  end

  defp handle_operation(operation, changeset) do
    changeset.repo.insert!(
      %Changeset{
        table_name: changeset.model.__struct__.__schema__(:source),
        record_id:  changeset.model.id,
        operation:  operation,
        changes:    changeset.changes,
      }
    )
  end

  def warp(model, repo, to: timestamp) do
    changes = repo.all(
      from c in Changeset,
          select: c.changes,
           where: c.inserted_at >= ^timestamp,
        order_by: [desc: c.inserted_at]
    )
    base = Map.take(model, model.__struct__.__schema__(:fields))
    Enum.reduce(changes, base, fn(c, m) ->
      change = for {key, val} <- c, into: %{}, do: {String.to_atom(key), val}
      Dict.merge(m, change)
    end)
    |> Map.put_new(:__struct__, model.__struct__)
  end
end
