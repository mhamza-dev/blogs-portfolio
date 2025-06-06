defmodule BlogsPortfolioWeb.PageLive do
  use BlogsPortfolioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign_data(socket)}
  end

  defp assign_data(socket) do
    socket
    |> assign(
      hero_content: %{
        title: "Sheharyar Naseer",
        bio: """
        <p class="mb-2 text-lg text-gray-700">
        I'm an Indie Nomad developer currently working out of Lahore (previously SF & NYC).
        </p>
        <p class="mb-4 text-lg text-gray-700">
          I <a href="#" class="underline">write</a>
          and <a href="#" class="underline">speak</a>
          about Engineering, Software Architecture, DevOps and on occasion; Security, Design and Community Building.
        </p>
        """
      },
      blog_posts: [
        %{
          title: "New Heights with Devfest Lahore 2023",
          inserted_at: ~U[2024-01-10T10:00:00Z]
        },
        %{
          title: "Quickly Dockerize your Apps with CloudUp",
          inserted_at: ~U[2023-02-04T10:00:00Z]
        },
        %{
          title: "Announcing Delta for Elixir",
          inserted_at: ~U[2021-08-13T10:00:00Z]
        },
        %{
          title: "Association Defaults in Ecto",
          inserted_at: ~U[2021-03-25T10:00:00Z]
        },
        %{
          title: "Interview by José Valim @ Dashbit",
          inserted_at: ~U[2021-01-12T10:00:00Z]
        },
        %{
          title: "Devfest 2020 Virtual",
          inserted_at: ~U[2020-10-19T10:00:00Z]
        }
      ]
    )
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto mt-32 px-20">
      <h1 class="text-5xl font-bold mb-4">{@hero_content.title}</h1>
      {raw(@hero_content.bio)}
      <div class="flex space-x-4 mb-12">
        <a href="#" class="text-gray-400 hover:text-gray-600" aria-label="GitHub">
          <i class="fa fa-github fa-lg"></i>
        </a>
        <a href="#" class="text-gray-400 hover:text-gray-600" aria-label="Twitter">
          <i class="fa fa-twitter fa-lg"></i>
        </a>
        <a href="#" class="text-gray-400 hover:text-gray-600" aria-label="Blog">
          <i class="fa fa-rss fa-lg"></i>
        </a>
        <a href="#" class="text-gray-400 hover:text-gray-600" aria-label="LinkedIn">
          <i class="fa fa-linkedin fa-lg"></i>
        </a>
      </div>
      <div class="flex flex-col md:flex-row gap-16 mt-16">
        <div class="flex-1">
          <h2 class="text-xs font-semibold text-gray-500 mb-4 tracking-widest">RECENT ARTICLES</h2>
          <ul class="space-y-2 text-sm">
            <li :for={post <- @blog_posts}>
              <span class="text-gray-400 mr-2">
                {Timex.format!(post.inserted_at, "{0M} {0D} '{YY}")}
              </span>
              {post.title}
            </li>
          </ul>
        </div>
      </div>
    </div>
    """
  end
end
