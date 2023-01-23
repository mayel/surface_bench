defmodule SurfaceBenchWeb.Dynamic.LiveComponents do

  defmodule StatefulComponent do
    use Surface.LiveComponent

    data label, :string, default: "Initial stateful"
    data assigned_in_update, :any

    def update(_assigns, socket) do
      {:ok, assign(socket, assigned_in_update: "Assigned in update/2")}
    end

    def render(assigns) do
      ~F"""
      <div :on-click="click" id="theDiv">{@label} - {@assigned_in_update}</div>
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, assign(socket, label: "Updated stateful")}
    end
  end

  defmodule StatefulPhoenixLiveComponent do
    use Phoenix.LiveComponent

    def update(_assigns, socket) do
      {:ok, assign(socket, assigned_in_update: "My assigned label")}
    end

    def render(assigns) do
      ~H"""
      <div>
        <span><%= @assigned_in_update %></span>
      </div>
      """
    end
  end

  defmodule StatefulComponentWithDefaultSlot do
    use Surface.LiveComponent

    slot default

    prop label, :string

    def render(assigns) do
      ~F"""
      <div id="theDiv">
        <#slot/>
        {@label}
      </div>
      """
    end
  end

  defmodule StatefulComponentWithEvent do
    use Surface.LiveComponent

    prop click, :event

    def render(assigns) do
      ~F"""
      <div :on-click={@click}/>
      """
    end
  end

  defmodule View do
    use Surface.LiveView
    alias Surface.Components.Dynamic.LiveComponent

    def render(assigns) do
      module = StatefulComponent

      ~F"""
      <LiveComponent module={module} id="comp"/>
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, assign(socket, label: "Updated stateless")}
    end
  end

  defmodule ViewWithPhoenixLiveComponent do
    use Surface.LiveView

    def render(assigns) do
      module = StatefulPhoenixLiveComponent

      ~F"""
      <LiveComponent
        id="comp"
        module={module}
        label="My label"
      />
      """
    end
  end

  defmodule ViewWithInnerContent do
    use Surface.LiveView
    alias Surface.Components.Dynamic.LiveComponent

    def render(assigns) do
      module = StatefulComponentWithDefaultSlot

      ~F"""
      <LiveComponent module={module} id="comp" label="my label">
        <span>Inner</span>
      </LiveComponent>
      """
    end
  end

end
