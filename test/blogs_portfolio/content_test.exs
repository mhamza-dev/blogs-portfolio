defmodule BlogsPortfolio.ContentTest do
  use BlogsPortfolio.DataCase

  alias BlogsPortfolio.Content

  describe "blog_posts" do
    alias BlogsPortfolio.Content.BlogPost

    import BlogsPortfolio.ContentFixtures

    @invalid_attrs %{title: nil, content: nil}

    test "list_blog_posts/0 returns all blog_posts" do
      blog_post = blog_post_fixture()
      assert Content.list_blog_posts() == [blog_post]
    end

    test "get_blog_post!/1 returns the blog_post with given id" do
      blog_post = blog_post_fixture()
      assert Content.get_blog_post!(blog_post.id) == blog_post
    end

    test "create_blog_post/1 with valid data creates a blog_post" do
      valid_attrs = %{title: "some title", content: "some content"}

      assert {:ok, %BlogPost{} = blog_post} = Content.create_blog_post(valid_attrs)
      assert blog_post.title == "some title"
      assert blog_post.content == "some content"
    end

    test "create_blog_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_blog_post(@invalid_attrs)
    end

    test "update_blog_post/2 with valid data updates the blog_post" do
      blog_post = blog_post_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content"}

      assert {:ok, %BlogPost{} = blog_post} = Content.update_blog_post(blog_post, update_attrs)
      assert blog_post.title == "some updated title"
      assert blog_post.content == "some updated content"
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

    test "list_hero_contents/0 returns all hero_contents" do
      hero_content = hero_content_fixture()
      assert Content.list_hero_contents() == [hero_content]
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
end
