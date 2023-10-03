defmodule Append.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  @repo :append |> Application.compile_env(:ecto_repos) |> List.first()
  @db_user Application.compile_env(:append, @repo)[:username]

  def change do
    create table(:addresses) do
      add :name, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :city, :string
      add :postcode, :string
      add :tel, :string

      timestamps()

    end

    execute("REVOKE UPDATE, DELETE ON TABLE addresses FROM #{@db_user}")
  end
end
