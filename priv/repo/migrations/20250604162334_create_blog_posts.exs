defmodule BlogsPortfolio.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :body, :text

      timestamps(type: :utc_datetime)
    end
  end
end
