defmodule BlogsPortfolioWeb.UserLive.BlogIndexTest do
  use BlogsPortfolioWeb.ConnCase
  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures

  describe "Blog Index" do
    test "renders list of blog posts", %{conn: conn} do
      # Create test blog posts
      _blog_post1 = blog_post_fixture(%{title: "First Post", body: "Content 1"})
      _blog_post2 = blog_post_fixture(%{title: "Second Post", body: "Content 2"})

      # Visit the blog index page
      {:ok, view, _html} = live(conn, "/blogs")

      # Test blog post listing
      assert has_element?(view, "a", "First Post")
      assert has_element?(view, "a", "Second Post")
      assert has_element?(view, ".back", "Back")
    end

    test "renders empty state when no blog posts exist", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/blogs")
      assert has_element?(view, "ul")
      refute has_element?(view, "li")
    end

    test "displays blog post dates", %{conn: conn} do
      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})
      {:ok, view, _html} = live(conn, "/blogs")

      assert has_element?(view, "span.text-gray-400")
      assert has_element?(view, "a[href='/blogs/#{blog_post.id}']")
    end
  end
end
