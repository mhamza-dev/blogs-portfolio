defmodule BlogsPortfolioWeb.PageLiveTest do
  use BlogsPortfolioWeb.ConnCase
  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures

  describe "Page Live" do
    test "renders page with blog posts and hero content", %{conn: conn} do
      # Create test data
      blog_post_fixture(%{title: "Test Post", body: "Test Content"})
      hero_content = hero_content_fixture(%{title: "Test Hero", bio: "Test Bio"})
      social_link_fixture(%{type: :github, hero_content_id: hero_content.id})

      # Visit the page
      {:ok, view, _html} = live(conn, "/")

      # Test hero content display
      assert has_element?(view, "h1", "Test Hero")
      assert has_element?(view, "p", "Test Bio")
      assert has_element?(view, "a[href*='github']")

      # Test blog post display
      assert has_element?(view, "h2", "Test Post")
    end

    test "renders empty state when no content exists", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      # Test empty state messages
      assert has_element?(view, "p", "No blog posts yet")
      assert has_element?(view, "p", "No hero content available")
    end

    test "renders limited number of blog posts", %{conn: conn} do
      # Create multiple blog posts with explicit timestamps
      now = DateTime.utc_now()

      blog_post_fixture(%{
        title: "First Post",
        body: "<p>Content 1</p>",
        inserted_at: DateTime.add(now, -2, :day)
      })

      blog_post_fixture(%{
        title: "Second Post",
        body: "<p>Content 2</p>",
        inserted_at: DateTime.add(now, -1, :day)
      })

      blog_post_fixture(%{title: "Third Post", body: "<p>Content 3</p>", inserted_at: now})

      {:ok, view, _html} = live(conn, "/")

      assert has_element?(view, "h2", "Third Post")
      assert has_element?(view, "h2", "Second Post")
      assert has_element?(view, "h2", "First Post")
    end
  end
end
