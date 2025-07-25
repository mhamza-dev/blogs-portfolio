defmodule BlogsPortfolioWeb.Router do
  use BlogsPortfolioWeb, :router

  import BlogsPortfolioWeb.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BlogsPortfolioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogsPortfolioWeb do
    pipe_through :browser

    live "/", PageLive

    scope "/blogs", UserLive do
      live "/", BlogIndex, :index
      live "/:id", BlogShow, :show
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogsPortfolioWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blogs_portfolio, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    # import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      # live_dashboard "/dashboard", metrics: BlogsPortfolioWeb.Telemetry
      # forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", BlogsPortfolioWeb do
    pipe_through [:browser, :redirect_if_admin_is_authenticated]

    live_session :redirect_if_admin_is_authenticated,
      on_mount: [{BlogsPortfolioWeb.AdminAuth, :redirect_if_admin_is_authenticated}] do
      live "/admins/log_in", AdminLoginLive, :new
      # live "/admins/reset_password", AdminForgotPasswordLive, :new
      # live "/admins/reset_password/:token", AdminResetPasswordLive, :edit
    end

    post "/admins/log_in", AdminSessionController, :create
  end

  scope "/", BlogsPortfolioWeb do
    pipe_through [:browser, :require_authenticated_admin]

    post "/trix-uploads", TrixUploadController, :create
    delete "/trix-uploads", TrixUploadController, :delete

    live_session :require_authenticated_admin,
      on_mount: [{BlogsPortfolioWeb.AdminAuth, :ensure_authenticated}] do
      # live "/admins/settings", AdminSettingsLive, :edit
      # live "/admins/settings/confirm_email/:token", AdminSettingsLive, :confirm_email
      scope "/admins/blogs", Admin.BlogsLive do
        live "/", Index, :index
        live "/new", Form, :new
        live "/:id/edit", Form, :edit
        live "/:id/show", Show, :show
      end

      scope "/admins/hero-content", Admin.HeroContentLive do
        live "/", Form
      end
    end
  end

  scope "/", BlogsPortfolioWeb do
    pipe_through [:browser]

    delete "/admins/log_out", AdminSessionController, :delete

    # live_session :current_admin,
    #   on_mount: [{BlogsPortfolioWeb.AdminAuth, :mount_current_admin}] do
    #   live "/admins/confirm/:token", AdminConfirmationLive, :edit
    #   live "/admins/confirm", AdminConfirmationInstructionsLive, :new
    # end
  end
end
