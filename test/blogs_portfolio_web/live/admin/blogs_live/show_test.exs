defmodule BlogsPortfolioWeb.Admin.BlogsLive.ShowTest do
  use BlogsPortfolioWeb.ConnCase
  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures
  import BlogsPortfolio.BackofficeFixtures

  describe "Blog Show" do
    test "renders blog post details", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post =
        blog_post_fixture(%{
          title: "Test Post",
          body: "<p>Test HTML content</p>"
        })

      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/show")

      # Test blog post display
      assert has_element?(view, "h1", "Test Post")
      assert has_element?(view, ".prose")
      assert has_element?(view, "span.text-gray-500")
    end

    test "displays formatted date", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})
      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/show")

      assert has_element?(view, "span.text-gray-500")
    end

    test "renders HTML content correctly", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post =
        blog_post_fixture(%{
          title: "Test Post",
          body: "<h2>Test Heading</h2><p>Test paragraph</p>"
        })

      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/show")

      assert has_element?(view, ".prose")
      assert has_element?(view, "h2", "Test Heading")
      assert has_element?(view, "p", "Test paragraph")
    end

    test "shows edit button on hover", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})
      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/show")

      # Edit button should be hidden by default
      assert has_element?(view, "a[href='/admins/blogs/#{blog_post.id}/edit']")
      assert has_element?(view, ".opacity-0")
    end
  end
end
