defmodule BlogsPortfolioWeb.Admin.BlogsLive.Show do
  use BlogsPortfolioWeb, :live_view
  alias BlogsPortfolio.Content

  def mount(%{"id" => id}, _session, socket) do
    {:ok, socket |> assign(:blog_post, Content.get_blog_post!(id))}
  end

  def render(assigns) do
    ~H"""
    <div class="gap-4">
      <.back navigate={~p"/admins/blogs"}>
        <p>Back to Blogs</p>
      </.back>
      <div class="mx-auto px-20 max-w-4xl">
        <div class="flex items-center mb-4 gap-4 group">
          <.header class="group-hover:text-zinc-700">{@blog_post.title}</.header>
          <.link
            navigate={~p"/admins/blogs/#{@blog_post.id}/edit"}
            class="opacity-0 group-hover:opacity-100 transition-opacity duration-200"
          >
            <.icon name="hero-pencil" class="w-4 h-4" />
          </.link>
        </div>
        <div class="flex justify-between items-center mb-4">
          <span class="text-sm text-gray-500">
            <.date date={@blog_post.inserted_at} />
          </span>
        </div>
        <div class="prose max-w-none">{raw(@blog_post.body)}</div>
      </div>
    </div>
    """
  end
end
