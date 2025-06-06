defmodule BlogsPortfolio.Content.HeroContent do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogsPortfolio.Content.SocialLink

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "hero_contents" do
    field :title, :string
    field :bio, :string

    timestamps(type: :utc_datetime)

    has_many :social_links, SocialLink
  end

  @doc false
  def changeset(hero_content, attrs) do
    hero_content
    |> cast(attrs, [:title, :bio])
    |> validate_required([:title, :bio])
    |> cast_assoc(:social_links, with: &SocialLink.changeset/2)
  end
end
