defmodule SurfaceBenchWeb.Router do
  use SurfaceBenchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SurfaceBenchWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SurfaceBenchWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/Components/ViewWithStateless", Components.ViewWithStateless
    live "/Components/ViewWithNested", Components.ViewWithNested
    live "/Components/ViewWithSlotArg", Components.ViewWithSlotArg
    live "/Components/ViewWithStatelessWithId", Components.ViewWithStatelessWithId
    live "/Components/ViewWithStatelessWithIdAndUpdate", Components.ViewWithStatelessWithIdAndUpdate

    live "/LiveComponents/View", LiveComponents.View

    live "/Dynamic/Components/ViewWithStateless", Dynamic.Components.ViewWithStateless
    live "/Dynamic/Components/ViewWithPhoenixFunctionComponent", Dynamic.Components.ViewWithPhoenixFunctionComponent
    live "/Dynamic/Components/ViewWithNested", Dynamic.Components.ViewWithNested
    live "/Dynamic/Components/ViewWithSlotArg", Dynamic.Components.ViewWithSlotArg
    live "/Dynamic/Components/ViewWithStatelessWithIdAndUpdate", Dynamic.Components.ViewWithStatelessWithIdAndUpdate
    
    live "/Dynamic/LiveComponents/View", Dynamic.LiveComponents.View
    live "/Dynamic/LiveComponents/ViewWithPhoenixLiveComponent", Dynamic.LiveComponents.ViewWithPhoenixLiveComponent
    live "/Dynamic/LiveComponents/ViewWithInnerContent", Dynamic.LiveComponents.ViewWithInnerContent

    live "/demo", Demo
  end

  scope "/", Phoenix.LiveViewTest do
    pipe_through :browser

    live "/LiveView/FunctionComponent/WithComponentLive", WithComponentLive
    live "/LiveView/FunctionComponent/WithMultipleTargets", WithMultipleTargets

    live "/LiveView/ComponentAndNestedInLive/NestedLive", ComponentAndNestedInLive.NestedLive

    live "/LiveView/ComponentInLive/Root", ComponentInLive.Root
    live "/LiveView/ComponentInLive/Live", ComponentInLive.Live

  end
  

  # Other scopes may use custom stacks.
  # scope "/api", SurfaceBenchWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser

  #     live_dashboard "/dashboard", metrics: SurfaceBenchWeb.Telemetry
  #   end
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
