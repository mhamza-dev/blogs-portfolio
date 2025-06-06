defmodule BlogsPortfolioWeb.Admin.BlogsLive.FormComponent do
  use BlogsPortfolioWeb, :live_component

  alias BlogsPortfolio.Content
  alias BlogsPortfolio.Content.BlogPost

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-2xl font-bold">
        {if @live_action == :new, do: "New Blog", else: "Edit Blog"}
      </h1>
      <.form
        for={@form}
        phx-change="validate"
        phx-submit="save"
        phx-target={@myself}
        class="flex flex-col gap-4"
      >
        <.input field={@form[:title]} label="Title" />
        <.trix_editor field={@form[:body]} label="Body" />
        <.button type="submit" phx-disable-with="Saving..." class="w-full">
          Save
        </.button>
      </.form>
    </div>
    """
  end

  def update(%{blog: blog} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(Content.change_blog_post(blog, %{}))}
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
