defmodule BlogsPortfolioWeb.Admin.BlogsLive.Index do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content

  def render(assigns) do
    ~H"""
    <div class="mx-auto px-20 max-w-8xl">
      <.header>
        Blogs
      </.header>
      <.link navigate={~p"/admins/blogs/new"} class="flex justify-end items-center gap-2 ">
        <.icon name="hero-plus" class="w-4 h-4" /> New Blog
      </.link>

      <.table id="blog-posts" rows={@blog_posts} row_id={fn blog_post -> blog_post.id end}>
        <:col :let={blog_post} label="Title">
          <.link navigate={~p"/admins/blogs/#{blog_post.id}/show"}>
            {blog_post.title}
          </.link>
        </:col>
        <:col :let={blog_post} label="Created At">
          <.date date={blog_post.inserted_at} />
        </:col>
        <:action :let={blog_post}>
          <.link navigate={~p"/admins/blogs/#{blog_post.id}/edit"}>
            <.icon name="hero-pencil" class="w-4 h-4" />
          </.link>
        </:action>
        <:action :let={blog_post}>
          <.button phx-click="delete" phx-value-id={blog_post.id} phx-confirm="Are you sure?">
            <.icon name="hero-trash" class="w-4 h-4" />
          </.button>
        </:action>
      </.table>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       blog_posts: Content.list_blog_posts(order_by: [desc: :inserted_at]),
       page_title: "Blogs"
     )}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    blog_post = Content.get_blog_post!(id)

    Content.delete_blog_post(blog_post)
    |> case do
      {:ok, _} ->
        send(self(), {:delete_blog_post, id})

        {:noreply,
         socket
         |> put_flash(:info, "Blog post deleted successfully")
         |> push_navigate(to: ~p"/admins/blogs")}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Failed to delete blog post")}
    end
  end

  def handle_event("show", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/admins/blogs/#{id}/show")}
  end

  def handle_info({:update_list, blog}, socket) do
    blog_posts =
      socket.assigns.blog_posts
      |> Enum.map(fn blog_post ->
        if blog_post.id == blog.id, do: blog, else: blog_post
      end)

    {:noreply, assign(socket, :blog_posts, blog_posts)}
  end

  def handle_info({:delete_blog_post, blog_id}, socket) do
    blog_posts =
      socket.assigns.blog_posts
      |> Enum.filter(fn blog_post -> blog_post.id != blog_id end)

    {:noreply, socket |> assign(:blog_posts, blog_posts)}
  end

  def handle_info({:create_blog_post, blog}, socket) do
    {:noreply, socket |> assign(:blog_posts, [blog | socket.assigns.blog_posts])}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end
end
