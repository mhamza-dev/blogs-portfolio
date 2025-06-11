defmodule BlogsPortfolioWeb.UserLive.BlogShowTest do
  use BlogsPortfolioWeb.ConnCase
  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures

  describe "Blog Show" do
    test "renders blog post details", %{conn: conn} do
      blog_post =
        blog_post_fixture(%{
          title: "Test Post",
          body: "<p>Test HTML content</p>"
        })

      {:ok, view, _html} = live(conn, "/blogs/#{blog_post.id}")

      # Test blog post display
      assert has_element?(view, "h1", "Test Post")
      assert has_element?(view, ".prose")
      assert has_element?(view, ".back", "Home")
      assert has_element?(view, "span.text-gray-500")
    end

    test "renders 404 for non-existent blog post", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        live(conn, "/blogs/999999")
      end
    end

    test "displays formatted date", %{conn: conn} do
      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})
      {:ok, view, _html} = live(conn, "/blogs/#{blog_post.id}")

      assert has_element?(view, "span.text-gray-500")
    end

    test "renders HTML content correctly", %{conn: conn} do
      blog_post =
        blog_post_fixture(%{
          title: "Test Post",
          body: "<h2>Test Heading</h2><p>Test paragraph</p>"
        })

      {:ok, view, _html} = live(conn, "/blogs/#{blog_post.id}")

      assert has_element?(view, ".prose")
      assert has_element?(view, "h2", "Test Heading")
      assert has_element?(view, "p", "Test paragraph")
    end
  end
end
