defmodule BlogsPortfolio.Repo.Migrations.CreateHeroContents do
  use Ecto.Migration

  def change do
    create table(:hero_contents, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :bio, :text

      timestamps(type: :utc_datetime)
    end
  end
end
