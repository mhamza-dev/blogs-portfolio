defmodule BlogsPortfolio.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogsPortfolio.Content` context.
  """

  @doc """
  Generate a blog_post.
  """
  def blog_post_fixture(attrs \\ %{}) do
    {:ok, blog_post} =
      attrs
      |> Enum.into(%{
        body: "some content",
        title: "some title",
        inserted_at: DateTime.utc_now()
      })
      |> BlogsPortfolio.Content.create_blog_post()

    blog_post
  end

  @doc """
  Generate a hero_content.
  """
  def hero_content_fixture(attrs \\ %{}) do
    {:ok, hero_content} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        title: "some title"
      })
      |> BlogsPortfolio.Content.create_hero_content()

    hero_content
  end

  @doc """
  Generate a social_link.
  """
  def social_link_fixture(attrs \\ %{}) do
    {:ok, social_link} =
      attrs
      |> Enum.into(%{
        type: :github,
        url: "https://github.com/test",
        icon: "fa-github"
      })
      |> BlogsPortfolio.Content.create_social_link()

    social_link
  end
end
