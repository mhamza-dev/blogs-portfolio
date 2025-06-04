defmodule BlogsPortfolio.Content.BlogPost do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "blog_posts" do
    field :title, :string
    field :content, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(blog_post, attrs) do
    blog_post
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
