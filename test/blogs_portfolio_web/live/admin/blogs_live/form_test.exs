defmodule BlogsPortfolioWeb.Admin.BlogsLive.FormTest do
  use BlogsPortfolioWeb.ConnCase
  import Phoenix.LiveViewTest
  import BlogsPortfolio.ContentFixtures
  import BlogsPortfolio.BackofficeFixtures

  describe "Blog Form" do
    test "renders form for new blog post", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      {:ok, view, _html} = live(conn, "/admins/blogs/new")

      assert has_element?(view, "h1", "New Blog")
      assert has_element?(view, "form")
      assert has_element?(view, "input[name='blog_post[title]']")
      assert has_element?(view, "button", "Save")
    end

    test "renders form for existing blog post", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post =
        blog_post_fixture(%{
          title: "Test Post",
          body: "<p>Test HTML content</p>"
        })

      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/edit")

      assert has_element?(view, "h1", "Edit Blog")
      assert has_element?(view, "input[value='Test Post']")
      assert has_element?(view, "div[data-trix-editor]")
    end

    test "validates required fields", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      {:ok, view, _html} = live(conn, "/admins/blogs/new")

      # Submit empty form
      view
      |> element("form")
      |> render_submit()

      assert has_element?(view, "p", "can't be blank")
    end

    test "creates new blog post", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      {:ok, view, _html} = live(conn, "/admins/blogs/new")

      # Fill form
      view
      |> element("form")
      |> render_submit(%{
        "blog_post" => %{
          "title" => "New Post",
          "body" => "<p>New content</p>"
        }
      })

      assert_redirect(view, ~p"/admins/blogs")
    end

    test "updates existing blog post", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post =
        blog_post_fixture(%{
          title: "Original Title",
          body: "<p>Original HTML content</p>"
        })

      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/edit")

      # Update form
      view
      |> element("form")
      |> render_submit(%{
        "blog_post" => %{
          "title" => "Updated Title",
          "body" => "<p>Updated HTML content</p>"
        }
      })

      assert_redirect(view, ~p"/admins/blogs")
    end

    test "handles validation errors", %{conn: conn} do
      user = admin_fixture()
      conn = log_in_admin(conn, user)

      blog_post =
        blog_post_fixture(%{
          title: "Original Title",
          body: "<p>Original Content</p>"
        })

      {:ok, view, _html} = live(conn, "/admins/blogs/#{blog_post.id}/edit")

      # Submit invalid form
      view
      |> element("form")
      |> render_submit(%{
        "blog_post" => %{
          "title" => "",
          "body" => ""
        }
      })

      assert has_element?(view, "p", "can't be blank")
    end
  end
end
