defmodule BlogsPortfolioWeb.UserLive.BlogIndex do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content

  def mount(_params, _session, socket) do
    blog_posts = Content.list_blog_posts()

    {:ok,
     socket
     |> assign(:blog_posts, blog_posts)}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto px-20 max-w-8xl">
      <.back navigate={~p"/"}>Back</.back>

      <div class="mt-16 max-w-5xl">
        <ul class="space-y-2 text-sm">
          <li :for={post <- @blog_posts} class="list-none">
            <span class="text-gray-400 mr-2">
              <.date date={post.inserted_at} format="MMM DD, YY" />
            </span>
            <.link navigate={~p"/blogs/#{post.id}"} class="text-gray-600 hover:text-gray-800">
              {post.title}
            </.link>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end
