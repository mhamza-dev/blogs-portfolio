defmodule BlogsPortfolio.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias BlogsPortfolio.Repo

  alias BlogsPortfolio.Content.BlogPost

  @doc """
  Returns the list of blog_posts.

  ## Examples

      iex> list_blog_posts()
      [%BlogPost{}, ...]

  """
  def list_blog_posts(query_params \\ []) do
    Enum.reduce(query_params, BlogPost, fn {key, value}, query ->
      case key do
        :limit -> query |> limit(^value)
        :offset -> query |> offset(^value)
        :order_by -> query |> order_by(^value)
        :where -> query |> where(^value)
        :preload -> query |> preload(^value)
        _ -> query
      end
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single blog_post.

  Raises `Ecto.NoResultsError` if the Blog post does not exist.

  ## Examples

      iex> get_blog_post!(123)
      %BlogPost{}

      iex> get_blog_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog_post!(id), do: Repo.get!(BlogPost, id)

  @doc """
  Creates a blog_post.

  ## Examples

      iex> create_blog_post(%{field: value})
      {:ok, %BlogPost{}}

      iex> create_blog_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog_post(attrs \\ %{}) do
    %BlogPost{}
    |> BlogPost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog_post.

  ## Examples

      iex> update_blog_post(blog_post, %{field: new_value})
      {:ok, %BlogPost{}}

      iex> update_blog_post(blog_post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog_post(%BlogPost{} = blog_post, attrs) do
    blog_post
    |> BlogPost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blog_post.

  ## Examples

      iex> delete_blog_post(blog_post)
      {:ok, %BlogPost{}}

      iex> delete_blog_post(blog_post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog_post(%BlogPost{} = blog_post) do
    Repo.delete(blog_post)
  end

  def delete_blog_post(id) when is_binary(id) do
    id
    |> get_blog_post!()
    |> delete_blog_post()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog_post changes.

  ## Examples

      iex> change_blog_post(blog_post)
      %Ecto.Changeset{data: %BlogPost{}}

  """
  def change_blog_post(%BlogPost{} = blog_post, attrs \\ %{}) do
    BlogPost.changeset(blog_post, attrs)
  end

  alias BlogsPortfolio.Content.HeroContent

  @doc """
  Returns the list of hero_contents.

  ## Examples

      iex> list_hero_contents()
      [%HeroContent{}, ...]

  """
  def list_hero_contents do
    HeroContent |> Repo.all() |> Repo.preload(:social_links)
  end

  @doc """
  Gets a single hero_content.

  Raises `Ecto.NoResultsError` if the Hero content does not exist.

  ## Examples

      iex> get_hero_content!(123)
      %HeroContent{}

      iex> get_hero_content!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hero_content!(id), do: Repo.get!(HeroContent, id)

  @doc """
  Creates a hero_content.

  ## Examples

      iex> create_hero_content(%{field: value})
      {:ok, %HeroContent{}}

      iex> create_hero_content(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hero_content(attrs \\ %{}) do
    %HeroContent{}
    |> HeroContent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hero_content.

  ## Examples

      iex> update_hero_content(hero_content, %{field: new_value})
      {:ok, %HeroContent{}}

      iex> update_hero_content(hero_content, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hero_content(%HeroContent{} = hero_content, attrs) do
    hero_content
    |> HeroContent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hero_content.

  ## Examples

      iex> delete_hero_content(hero_content)
      {:ok, %HeroContent{}}

      iex> delete_hero_content(hero_content)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hero_content(%HeroContent{} = hero_content) do
    Repo.delete(hero_content)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hero_content changes.

  ## Examples

      iex> change_hero_content(hero_content)
      %Ecto.Changeset{data: %HeroContent{}}

  """
  def change_hero_content(%HeroContent{} = hero_content, attrs \\ %{}) do
    HeroContent.changeset(hero_content, attrs)
  end

  alias BlogsPortfolio.Content.SocialLink

  @doc """
  Returns the list of social_link.

  ## Examples

      iex> list_social_link()
      [%SocialLink{}, ...]

  """
  def list_social_link do
    Repo.all(SocialLink)
  end

  @doc """
  Gets a single social_link.

  Raises `Ecto.NoResultsError` if the Social link does not exist.

  ## Examples

      iex> get_social_link!(123)
      %SocialLink{}

      iex> get_social_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_social_link!(id), do: Repo.get!(SocialLink, id)

  @doc """
  Creates a social_link.

  ## Examples

      iex> create_social_link(%{field: value})
      {:ok, %SocialLink{}}

      iex> create_social_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_social_link(attrs \\ %{}) do
    %SocialLink{}
    |> SocialLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a social_link.

  ## Examples

      iex> update_social_link(social_link, %{field: new_value})
      {:ok, %SocialLink{}}

      iex> update_social_link(social_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_social_link(%SocialLink{} = social_link, attrs) do
    social_link
    |> SocialLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a social_link.

  ## Examples

      iex> delete_social_link(social_link)
      {:ok, %SocialLink{}}

      iex> delete_social_link(social_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_social_link(%SocialLink{} = social_link) do
    Repo.delete(social_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking social_link changes.

  ## Examples

      iex> change_social_link(social_link)
      %Ecto.Changeset{data: %SocialLink{}}

  """
  def change_social_link(%SocialLink{} = social_link, attrs \\ %{}) do
    SocialLink.changeset(social_link, attrs)
  end
end
