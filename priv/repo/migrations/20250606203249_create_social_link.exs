defmodule BlogsPortfolio.Repo.Migrations.CreateSocialLink do
  use Ecto.Migration

  def change do
    create table(:social_link, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :url, :text
      add :icon, :string

      add :hero_content_id, references(:hero_contents, type: :binary_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:social_link, [:type, :hero_content_id], name: :social_link_type_index)
    create unique_index(:social_link, [:url, :hero_content_id], name: :social_link_url_index)
  end
end
