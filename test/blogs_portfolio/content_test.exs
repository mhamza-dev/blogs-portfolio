defmodule BlogsPortfolio.ContentTest do
  use BlogsPortfolio.DataCase

  alias BlogsPortfolio.Content

  describe "blog_posts" do
    alias BlogsPortfolio.Content.BlogPost

    import BlogsPortfolio.ContentFixtures

    @invalid_attrs %{title: nil, body: nil}

    test "list_blog_posts/0 returns all blog_posts" do
      blog_post = blog_post_fixture()
      assert Content.list_blog_posts() == [blog_post]
    end

    test "list_blog_posts/1 with limit returns limited blog_posts" do
      blog_post1 = blog_post_fixture(%{title: "First Post", body: "Content 1"})
      blog_post2 = blog_post_fixture(%{title: "Second Post", body: "Content 2"})
      blog_post_fixture(%{title: "Third Post", body: "Content 3"})

      assert length(Content.list_blog_posts(limit: 2)) == 2
      result_ids = Content.list_blog_posts(limit: 2) |> Enum.map(& &1.id)
      assert blog_post1.id in result_ids
      assert blog_post2.id in result_ids
    end

    test "get_blog_post!/1 returns the blog_post with given id" do
      blog_post = blog_post_fixture()
      assert Content.get_blog_post!(blog_post.id) == blog_post
    end

    test "create_blog_post/1 with valid data creates a blog_post" do
      valid_attrs = %{title: "some title", body: "some content"}

      assert {:ok, %BlogPost{} = blog_post} = Content.create_blog_post(valid_attrs)
      assert blog_post.title == "some title"
      assert blog_post.body == "some content"
    end

    test "create_blog_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_blog_post(@invalid_attrs)
    end

    test "update_blog_post/2 with valid data updates the blog_post" do
      blog_post = blog_post_fixture()
      update_attrs = %{title: "some updated title", body: "some updated content"}

      assert {:ok, %BlogPost{} = blog_post} = Content.update_blog_post(blog_post, update_attrs)
      assert blog_post.title == "some updated title"
      assert blog_post.body == "some updated content"
    end

    test "update_blog_post/2 with invalid data returns error changeset" do
      blog_post = blog_post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_blog_post(blog_post, @invalid_attrs)
      assert blog_post == Content.get_blog_post!(blog_post.id)
    end

    test "delete_blog_post/1 deletes the blog_post" do
      blog_post = blog_post_fixture()
      assert {:ok, %BlogPost{}} = Content.delete_blog_post(blog_post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_blog_post!(blog_post.id) end
    end

    test "change_blog_post/1 returns a blog_post changeset" do
      blog_post = blog_post_fixture()
      assert %Ecto.Changeset{} = Content.change_blog_post(blog_post)
    end
  end

  describe "hero_contents" do
    alias BlogsPortfolio.Content.HeroContent

    import BlogsPortfolio.ContentFixtures

    @invalid_attrs %{title: nil, bio: nil}

    test "list_hero_contents/0 returns all hero_contents with preloaded social_links" do
      hero_content = hero_content_fixture()
      social_link = social_link_fixture(%{hero_content_id: hero_content.id})

      [loaded_hero] = Content.list_hero_contents()
      assert loaded_hero.id == hero_content.id
      assert length(loaded_hero.social_links) == 1
      [loaded_social] = loaded_hero.social_links
      assert loaded_social.id == social_link.id
    end

    test "get_hero_content!/1 returns the hero_content with given id" do
      hero_content = hero_content_fixture()
      assert Content.get_hero_content!(hero_content.id) == hero_content
    end

    test "create_hero_content/1 with valid data creates a hero_content" do
      valid_attrs = %{title: "some title", bio: "some bio"}

      assert {:ok, %HeroContent{} = hero_content} = Content.create_hero_content(valid_attrs)
      assert hero_content.title == "some title"
      assert hero_content.bio == "some bio"
    end

    test "create_hero_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_hero_content(@invalid_attrs)
    end

    test "update_hero_content/2 with valid data updates the hero_content" do
      hero_content = hero_content_fixture()
      update_attrs = %{title: "some updated title", bio: "some updated bio"}

      assert {:ok, %HeroContent{} = hero_content} =
               Content.update_hero_content(hero_content, update_attrs)

      assert hero_content.title == "some updated title"
      assert hero_content.bio == "some updated bio"
    end

    test "update_hero_content/2 with invalid data returns error changeset" do
      hero_content = hero_content_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Content.update_hero_content(hero_content, @invalid_attrs)

      assert hero_content == Content.get_hero_content!(hero_content.id)
    end

    test "delete_hero_content/1 deletes the hero_content" do
      hero_content = hero_content_fixture()
      assert {:ok, %HeroContent{}} = Content.delete_hero_content(hero_content)
      assert_raise Ecto.NoResultsError, fn -> Content.get_hero_content!(hero_content.id) end
    end

    test "change_hero_content/1 returns a hero_content changeset" do
      hero_content = hero_content_fixture()
      assert %Ecto.Changeset{} = Content.change_hero_content(hero_content)
    end
  end

  describe "social_link" do
    alias BlogsPortfolio.Content.SocialLink

    import BlogsPortfolio.ContentFixtures

    @invalid_attrs %{type: nil}

    test "list_social_link/0 returns all social_link" do
      social_link = social_link_fixture()
      assert Content.list_social_link() == [social_link]
    end

    test "get_social_link!/1 returns the social_link with given id" do
      social_link = social_link_fixture()
      assert Content.get_social_link!(social_link.id) == social_link
    end

    test "create_social_link/1 with hero_content association creates a social_link" do
      hero_content = hero_content_fixture()
      valid_attrs = %{type: :github, hero_content_id: hero_content.id}

      assert {:ok, %SocialLink{} = social_link} = Content.create_social_link(valid_attrs)
      assert social_link.type == :github
      assert social_link.hero_content_id == hero_content.id
    end

    test "create_social_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_social_link(@invalid_attrs)
    end

    test "update_social_link/2 with valid data updates the social_link" do
      social_link = social_link_fixture()
      update_attrs = %{type: :facebook}

      assert {:ok, %SocialLink{} = social_link} =
               Content.update_social_link(social_link, update_attrs)

      assert social_link.type == :facebook
    end

    test "update_social_link/2 with invalid data returns error changeset" do
      social_link = social_link_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_social_link(social_link, @invalid_attrs)
      assert social_link == Content.get_social_link!(social_link.id)
    end

    test "delete_social_link/1 deletes the social_link" do
      social_link = social_link_fixture()
      assert {:ok, %SocialLink{}} = Content.delete_social_link(social_link)
      assert_raise Ecto.NoResultsError, fn -> Content.get_social_link!(social_link.id) end
    end

    test "change_social_link/1 returns a social_link changeset" do
      social_link = social_link_fixture()
      assert %Ecto.Changeset{} = Content.change_social_link(social_link)
    end
  end
end
