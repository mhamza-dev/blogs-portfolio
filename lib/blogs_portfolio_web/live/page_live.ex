defmodule BlogsPortfolioWeb.PageLive do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content

  def mount(_params, _session, socket) do
    hero_content = Content.list_hero_contents() |> List.first()
    blog_posts = Content.list_blog_posts(limit: 3, order_by: [desc: :inserted_at])

    {:ok,
     socket
     |> assign(:hero_content, hero_content)
     |> assign(:blog_posts, blog_posts)}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto mt-32 px-20">
      <div :if={@hero_content}>
        <h1 class="text-5xl font-bold mb-4">{@hero_content.title}</h1>
        <p>{raw(@hero_content.bio)}</p>
        <div class="flex space-x-4 mt-8 mb-12">
          <a
            :for={social_link <- @hero_content.social_links}
            href={social_link.url}
            target="_blank"
            rel="noopener noreferrer"
            class="text-gray-400 hover:text-gray-600"
            aria-label={String.capitalize(Atom.to_string(social_link.type))}
          >
            <.font_awesome_icon name={social_link.icon} />
          </a>
        </div>
      </div>
      <div :if={!@hero_content}>
        <h1 class="text-5xl font-bold mb-4">No Hero Content</h1>
        <div class="flex space-x-4 mb-12">
          <p>No hero content available</p>
        </div>
      </div>
      <div class="flex flex-col md:flex-row gap-16 mt-16">
        <div class="flex-1">
          <h2 class="text-xs font-semibold text-gray-500 mb-4 tracking-widest">RECENT ARTICLES</h2>
          <ul class="space-y-4">
            <li :for={post <- @blog_posts} class="list-none">
              <h2 class="text-lg font-semibold">
                <span class="text-gray-400 mr-2 text-sm">
                  <.date date={post.inserted_at} format="MMM DD, YY" />
                </span>
                <.link navigate={~p"/blogs/#{post.id}"} class="text-gray-600 hover:text-gray-800">
                  {post.title}
                </.link>
              </h2>
            </li>
          </ul>
          <p :if={@blog_posts == []} class="text-gray-500">No blog posts yet</p>
          <.link
            navigate={~p"/blogs"}
            class="mt-6 text-gray-600 space-x-2 text-sm hover:text-gray-800"
          >
            View All Blogs <.icon name="hero-arrow-right" class="w-4 h-4" />
          </.link>
        </div>
      </div>
    </div>
    """
  end
end
