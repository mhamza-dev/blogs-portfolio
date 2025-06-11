defmodule BlogsPortfolioWeb.UserLive.BlogShow do
  use BlogsPortfolioWeb, :live_view
  alias BlogsPortfolio.Content

  def mount(%{"id" => id}, _session, socket) do
    blog_post =
      case Ecto.UUID.cast(id) do
        {:ok, uuid} -> Content.get_blog_post!(uuid)
        :error -> raise Ecto.NoResultsError, queryable: Content.BlogPost
      end

    {:ok, socket |> assign(:blog_post, blog_post)}
  end

  def render(assigns) do
    ~H"""
    <div class="gap-4">
      <.back navigate={~p"/"}>
        <p>Home</p>
      </.back>
      <div class="mx-auto px-20 max-w-4xl">
        <.header class="group-hover:text-zinc-700">{@blog_post.title}</.header>
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
