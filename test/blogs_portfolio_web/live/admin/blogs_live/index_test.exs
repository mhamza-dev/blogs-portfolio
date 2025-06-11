defmodule BlogsPortfolioWeb.Admin.BlogsLive.IndexTest do
  use BlogsPortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures
  import BlogsPortfolio.BackofficeFixtures

  describe "Blog Index" do
    test "renders list of blog posts", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      _blog_post1 = blog_post_fixture(%{title: "First Post", body: "Content 1"})
      _blog_post2 = blog_post_fixture(%{title: "Second Post", body: "Content 2"})

      {:ok, view, _html} = live(conn, "/admins/blogs")
      # Test header and new blog button
      assert has_element?(view, "h1", "Blogs")
      assert has_element?(view, "a", "New Blog")

      # Test blog post listing
      assert has_element?(view, "a", "First Post")
      assert has_element?(view, "a", "Second Post")
    end

    test "deletes blog post", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post = blog_post_fixture()
      {:ok, view, _html} = live(conn, "/admins/blogs")

      assert view
             |> element("button[phx-click='delete']")
             |> render_click(%{"id" => blog_post.id})

      assert_redirect(view, ~p"/admins/blogs")
    end

    test "navigates to show page", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)
      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})

      {:ok, view, _html} = live(conn, "/admins/blogs")

      # Click on blog post title
      view
      |> element("a", "Test Post")
      |> render_click()

      assert_redirect(view, "/admins/blogs/#{blog_post.id}/show")
    end

    test "navigates to edit page", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)
      blog_post = blog_post_fixture(%{title: "Test Post", body: "Content"})

      {:ok, view, _html} = live(conn, "/admins/blogs")

      # Click edit button
      view
      |> element("a[href='/admins/blogs/#{blog_post.id}/edit']")
      |> render_click()

      assert_redirect(view, "/admins/blogs/#{blog_post.id}/edit")
    end

    test "updates list when blog post is created", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)
      {:ok, view, _html} = live(conn, "/admins/blogs")

      # Simulate blog post creation
      blog_post = blog_post_fixture(%{title: "New Post", body: "Content"})
      send(view.pid, {:create_blog_post, blog_post})

      assert has_element?(view, "a", "New Post")
    end

    test "updates list when blog post is updated", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)
      blog_post = blog_post_fixture(%{title: "Original Title", body: "Content"})
      {:ok, view, _html} = live(conn, "/admins/blogs")

      # Simulate blog post update
      updated_blog = %{blog_post | title: "Updated Title"}
      send(view.pid, {:update_list, updated_blog})

      assert has_element?(view, "a", "Updated Title")
      refute has_element?(view, "a", "Original Title")
    end
  end
end
