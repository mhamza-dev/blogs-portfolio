defmodule BlogsPortfolioWeb.Admin.HeroContentLive.Form do
  use BlogsPortfolioWeb, :live_view

  alias BlogsPortfolio.Content
  alias BlogsPortfolio.Content.{HeroContent, SocialLink}

  @social_link_param %{type: "", url: "", icon: "hero-link"}

  def render(assigns) do
    ~H"""
    <div class="gap-4">
      <.back navigate={~p"/"}>
        <p>Home</p>
      </.back>
      <div class="mx-auto px-20 max-w-4xl">
        <.header>
          {@page_title}
        </.header>
        <.form for={@form} phx-change="validate" phx-submit="save" class="flex flex-col gap-4">
          <.input field={@form[:title]} label="Title" />
          <.trix_editor field={@form[:bio]} label="Bio" />
          <div class="flex flex-col gap-4">
            <div class="flex items-center justify-between">
              <h3 class="text-lg font-semibold">Social Links</h3>
              <.button type="button" phx-click="add_social_link" class="flex items-center gap-2">
                <.icon name="hero-plus" class="w-4 h-4" /> Add Social Link
              </.button>
            </div>
            <.inputs_for :let={sl} field={@form[:social_links]}>
              <div class="flex items-end p-4 border rounded-lg justify-between">
                <div class="flex gap-4 items-end">
                  <.input field={sl[:type]} type="select" label="Type" options={@social_handles} />
                  <.input field={sl[:url]} label="URL" />
                  <.input field={sl[:icon]} type="hidden" />
                </div>
                <.button
                  type="button"
                  phx-click="remove_social_link"
                  phx-value-index={sl.index}
                  class="text-red-500 bg-red-500/10 hover:bg-red-500/40"
                >
                  <.icon name="hero-trash" class="w-4 h-4" />
                </.button>
              </div>
            </.inputs_for>
          </div>
          <.button type="submit" phx-disable-with="Saving..." class="w-full">
            Save
          </.button>
        </.form>
      </div>
    </div>
    """
  end

  def mount(_, _, socket) do
    hd_content = Content.list_hero_contents() |> List.first()

    hero_content =
      if hd_content, do: hd_content, else: %HeroContent{social_links: []}

    {:ok,
     socket
     |> assign(
       page_title: "Hero Content",
       hero_content: hero_content,
       has_content: hd_content != nil,
       social_handles: SocialLink.social_handles()
     )
     |> assign_form(Content.change_hero_content(hero_content, %{}))}
  end

  def handle_event("add_social_link", _params, socket) do
    changeset = socket.assigns.form.source
    current_social_links = Ecto.Changeset.get_field(changeset, :social_links) || []
    updated_social_links = current_social_links ++ [@social_link_param]

    {:noreply,
     socket
     |> assign_form(
       changeset
       |> Ecto.Changeset.put_assoc(:social_links, updated_social_links)
     )}
  end

  def handle_event("remove_social_link", %{"index" => index}, socket) do
    changeset = socket.assigns.form.source
    current_social_links = Ecto.Changeset.get_field(changeset, :social_links)
    updated_social_links = List.delete_at(current_social_links, String.to_integer(index))

    {:noreply,
     socket
     |> assign_form(
       changeset
       |> Ecto.Changeset.put_assoc(:social_links, updated_social_links)
     )}
  end

  def handle_event("validate", %{"hero_content" => params}, socket) do
    changeset =
      socket.assigns.hero_content
      |> HeroContent.changeset(params)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"hero_content" => params}, socket) do
    save_hero_content(socket, socket.assigns.has_content, params)
  end

  defp save_hero_content(socket, true, params) do
    dbg(params)

    case Content.update_hero_content(socket.assigns.hero_content, params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Hero content updated successfully")
         |> push_navigate(to: ~p"/")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_hero_content(socket, false, params) do
    case Content.create_hero_content(params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Hero content created successfully")
         |> push_navigate(to: ~p"/")}

      {:error, changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, changeset) do
    socket
    |> assign(:form, to_form(changeset))
  end
end
