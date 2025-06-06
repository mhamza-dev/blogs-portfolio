defmodule BlogsPortfolioWeb.Admin.BlogsLive.Form do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content
  alias BlogsPortfolio.Content.BlogPost

  def render(assigns) do
    ~H"""
    <div class="gap-4">
      <.back navigate={~p"/admins/blogs"}>
        <p>Back to Blogs</p>
      </.back>
      <div class="mx-auto px-20 max-w-4xl">
        <.header>
          {@page_title}
        </.header>
        <.form for={@form} phx-change="validate" phx-submit="save" class="flex flex-col gap-4">
          <.input field={@form[:title]} label="Title" />
          <.trix_editor field={@form[:body]} label="Body" />
          <.button type="submit" phx-disable-with="Saving..." class="w-full">
            Save
          </.button>
        </.form>
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    blog = Content.get_blog_post!(id)

    socket
    |> assign(page_title: "Edit Blog", blog: blog)
    |> assign_form(Content.change_blog_post(blog, %{}))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(page_title: "New Blog", blog: %BlogPost{})
    |> assign_form(Content.change_blog_post(%BlogPost{}, %{}))
  end

  def handle_event("validate", %{"blog_post" => params}, socket) do
    changeset =
      socket.assigns.blog
      |> BlogPost.changeset(params)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"blog_post" => params}, socket) do
    save_blog_post(socket, socket.assigns.live_action, params)
  end

  defp save_blog_post(socket, :new, params) do
    case Content.create_blog_post(params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blog post created successfully")
         |> push_navigate(to: ~p"/admins/blogs")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_blog_post(socket, :edit, params) do
    case Content.update_blog_post(socket.assigns.blog, params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blog post updated successfully")
         |> push_navigate(to: ~p"/admins/blogs")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    socket
    |> assign(:form, to_form(changeset))
  end
end
