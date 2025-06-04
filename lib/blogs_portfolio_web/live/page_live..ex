defmodule BlogsPortfolioWeb.Live.PageLive do
  use BlogsPortfolioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Hello World</h1>
    </div>
    """
  end
end
