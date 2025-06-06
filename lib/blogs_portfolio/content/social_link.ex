defmodule BlogsPortfolio.Content.SocialLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias BlogsPortfolio.Content.HeroContent

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @social_handles [
    :github,
    :facebook,
    :youtube,
    :x,
    :instagram,
    :thread,
    :gitlab,
    :stack_overflow,
    :bitbucket,
    :devto,
    :hashnode,
    :codepen,
    :jsfiddle,
    :replit,
    :hackerrank,
    :leetcode,
    :codeforces,
    :topcoder,
    :kaggle,
    :medium,
    :reddit,
    :discord,
    :slack,
    :linkedin,
    :bluesky,
    :mastodon,
    :twitch
  ]

  schema "social_link" do
    field :type, Ecto.Enum, values: @social_handles
    field :url, :string
    field :icon, :string

    timestamps(type: :utc_datetime)

    belongs_to :hero_content, HeroContent
  end

  @doc false
  def changeset(social_link, attrs) do
    social_link
    |> cast(attrs, [:type, :url, :icon])
    |> validate_required([:type, :url, :icon])
    |> validate_inclusion(:type, @social_handles)
    |> unique_constraint(:type, name: :social_link_type_index)
    |> unique_constraint(:url, name: :social_link_url_index)
  end

  def social_handles,
    do:
      Enum.map(@social_handles, fn value ->
        {value |> Atom.to_string() |> String.capitalize(), value}
      end)
end
