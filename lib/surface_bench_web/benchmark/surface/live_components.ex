defmodule SurfaceBenchWeb.LiveComponents do

  defmodule StatelessComponent do
    use Surface.Component

    prop label, :string

    def render(assigns) do
      ~F"""
      <div phx-click="click">{@label}</div>
      """
    end
  end

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

  defmodule View do
    use Surface.LiveView

    data label, :string, default: "Initial stateless"

    def render(assigns) do
      ~F"""
      <StatelessComponent label={@label} />
      <StatefulComponent id="comp" />
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, assign(socket, label: "Updated stateless")}
    end
  end

  defmodule InfoProvider do
    use Surface.Component

    slot default, arg: %{info: :string}

    def render(assigns) do
      info = "Hi there!"

      ~F"""
      <div>
        <#slot {@default, info: info}/>
      </div>
      """
    end
  end

  defmodule InfoProviderWithoutSlotArg do
    use Surface.Component

    slot default

    def render(assigns) do
      ~F"""
      <div>
        <#slot/>
      </div>
      """
    end
  end

  defmodule LiveComponentWithEvent do
    use Surface.LiveComponent

    prop event, :event

    def render(assigns) do
      ~F"""
      <button :on-click={@event} />
      """
    end
  end

  defmodule LiveComponentDataWithoutDefault do
    use Surface.LiveComponent

    data count, :integer

    def render(assigns) do
      ~F"""
      <div>{Map.has_key?(assigns, :count)}</div>
      """
    end
  end

end
