# defmodule BlogsPortfolioWeb.Admin.HeroContentLive.FormTest do
#   use BlogsPortfolioWeb.ConnCase
#   import Phoenix.LiveViewTest
#   import BlogsPortfolio.ContentFixtures

#   describe "Hero Content Form" do
#     test "renders form for new hero content", %{conn: conn} do
#       {:ok, view, _html} = live(conn, "/admins/hero-content/new")

#       assert has_element?(view, "h1", "Hero Content")
#       assert has_element?(view, "form")
#       assert has_element?(view, "input[name='hero_content[title]']")
#       assert has_element?(view, "div[data-trix-editor]")
#       assert has_element?(view, "button", "Add Social Link")
#     end

#     test "renders form for existing hero content", %{conn: conn} do
#       _hero_content =
#         hero_content_fixture(%{
#           title: "Test Hero",
#           bio: "Test Bio"
#         })

#       {:ok, view, _html} = live(conn, "/admins/hero-content/edit")

#       assert has_element?(view, "input[value='Test Hero']")
#       assert has_element?(view, "div[data-trix-editor]")
#     end

#     test "validates required fields", %{conn: conn} do
#       {:ok, view, _html} = live(conn, "/admins/hero-content/new")

#       # Submit empty form
#       view
#       |> element("form")
#       |> render_submit()

#       assert has_element?(view, "span", "can't be blank")
#     end

#     test "adds and removes social links", %{conn: conn} do
#       {:ok, view, _html} = live(conn, "/admin/hero-content/new")

#       # Add social link
#       view
#       |> element("button", "Add Social Link")
#       |> render_click()

#       assert has_element?(view, "select[name='hero_content[social_links][0][type]']")
#       assert has_element?(view, "input[name='hero_content[social_links][0][url]']")

#       # Remove social link
#       view
#       |> element("button[phx-click='remove_social_link']")
#       |> render_click(%{"index" => "0"})

#       refute has_element?(view, "select[name='hero_content[social_links][0][type]']")
#     end

#     test "creates new hero content", %{conn: conn} do
#       {:ok, view, _html} = live(conn, "/admin/hero-content/new")

#       # Fill form
#       view
#       |> element("form")
#       |> render_submit(%{
#         "hero_content" => %{
#           "title" => "New Hero",
#           "bio" => "New Bio",
#           "social_links" => [
#             %{
#               "type" => "github",
#               "url" => "https://github.com/test"
#             }
#           ]
#         }
#       })

#       assert_redirect(view, "/")
#     end

#     test "updates existing hero content", %{conn: conn} do
#       _hero_content =
#         hero_content_fixture(%{
#           title: "Original Title",
#           bio: "Original Bio"
#         })

#       {:ok, view, _html} = live(conn, "/admin/hero-content/edit")

#       # Update form
#       view
#       |> element("form")
#       |> render_submit(%{
#         "hero_content" => %{
#           "title" => "Updated Title",
#           "bio" => "Updated Bio"
#         }
#       })

#       assert_redirect(view, "/")
#     end
#   end
# end
