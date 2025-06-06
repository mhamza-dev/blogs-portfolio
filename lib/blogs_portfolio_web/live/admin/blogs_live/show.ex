defmodule BlogsPortfolioWeb.Admin.BlogsLive.Show do
  use BlogsPortfolioWeb, :live_view
  alias BlogsPortfolio.Content

  def mount(%{"id" => id}, _session, socket) do
    {:ok, socket |> assign(:blog_post, Content.get_blog_post!(id))}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto mt-32 px-20 max-w-8xl">
      <.header>
        <:subtitle>
          <.link navigate={~p"/admins/blogs"}>
            <.icon name="hero-arrow-left" class="w-5 h-5" /> Back to Blogs
          </.link>
        </:subtitle>
        {@blog_post.title}
      </.header>
      <div class="prose max-w-none">{raw(@blog_post.body)}</div>
      <div class="flex justify-between items-center mb-4">
        <span class="text-sm text-gray-500">
          <.date date={@blog_post.inserted_at} />
        </span>
      </div>
    </div>
    """
  end
end
