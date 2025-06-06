defmodule BlogsPortfolioWeb.Admin.BlogsLive.Index do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content
  alias BlogsPortfolio.Content.BlogPost

  alias BlogsPortfolioWeb.Admin.BlogsLive.FormComponent

  def render(assigns) do
    ~H"""
    <div class="mx-auto mt-32 px-20 max-w-8xl">
      <.header>
        Blogs
      </.header>
      <.modal
        :if={@live_action in [:new, :edit]}
        id={if @live_action == :new, do: "blog-modal-new", else: "blog-modal-#{@blog && @blog.id}"}
        on_cancel={JS.navigate(~p"/admins/blogs")}
        show={@live_action in [:new, :edit]}
      >
        <.live_component
          module={FormComponent}
          id="blog-form"
          blog={@blog}
          live_action={@live_action}
        />
      </.modal>
      <.link navigate={~p"/admins/blogs/new"} class="flex justify-end items-center gap-2 ">
        <.icon name="hero-plus" class="w-4 h-4" /> New Blog
      </.link>

      <.table
        id="blog-posts"
        rows={@blog_posts}
        row_id={fn blog_post -> blog_post.id end}
        row_click={fn _ -> "show" end}
      >
        <:col :let={blog_post} label="Title">
          <.link href={~p"/admins/blogs/#{blog_post.id}/show"}>
            {blog_post.title}
          </.link>
        </:col>
        <:col :let={blog_post} label="Created At">
          <.date date={blog_post.inserted_at} />
        </:col>
        <:action :let={blog_post}>
          <.link href={~p"/admins/blogs/#{blog_post.id}/edit"}>
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
    {:ok, assign(socket, :blog_posts, Content.list_blog_posts())}
  end

  def handle_params(params, _url, socket) do
    IO.inspect(params)
    IO.inspect(socket.assigns.live_action)
    {:noreply, apply_action(socket, params, socket.assigns.live_action)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    Content.delete_blog_post(id)
    |> case do
      {:ok, _} ->
        send(self(), {:delete_blog_post, id})
        {:noreply, put_flash(socket, :info, "Blog post deleted successfully")}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Failed to delete blog post")}
    end
  end

  def handle_event("show", %{"id" => id}, socket) do
    {:noreply, push_navigate(socket, to: ~p"/admins/blogs/#{id}/show")}
  end

  defp apply_action(socket, _, :index) do
    socket
    |> assign(:page_title, "Blogs")
  end

  defp apply_action(socket, _, :new) do
    socket
    |> assign(:page_title, "New Blog")
    |> assign(:blog, %BlogPost{})
  end

  defp apply_action(socket, %{"id" => id}, :edit) do
    socket
    |> assign(:page_title, "Edit Blog")
    |> assign(:blog, Content.get_blog_post!(id))
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
end
