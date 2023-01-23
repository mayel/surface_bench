defmodule SurfaceBenchWeb.Dynamic.Components do

  defmodule Stateless do
    use Surface.Component

    prop label, :string, default: ""
    prop class, :css_class

    def render(assigns) do
      ~F"""
      <div class={@class}>
        <span>{@label}</span>
      </div>
      """
    end
  end

  defmodule ComponentWithEvent do
    use Surface.Component

    prop click, :event

    def render(assigns) do
      ~F"""
      <div :on-click={@click}/>
      """
    end
  end

  defmodule PhoenixFunctionComponent do
    use Phoenix.Component

    def show(assigns) do
      ~H"""
      <div class={@class}>
        <span><%= @label %></span>
      </div>
      """
    end
  end

  defmodule Outer do
    use Surface.Component

    slot default

    def render(assigns) do
      ~F"""
      <div><#slot/></div>
      """
    end
  end

  defmodule Inner do
    use Surface.Component

    def render(assigns) do
      ~F"""
      <span>Inner</span>
      """
    end
  end

  defmodule OuterWithSlotArg do
    use Surface.Component

    slot default, arg: %{info: :string}

    def render(assigns) do
      info = "My info"

      ~F"""
      <div><#slot {@default, info: info}/></div>
      """
    end
  end

  defmodule ViewWithStateless do
    use Surface.LiveView

    def render(assigns) do
      module = Stateless

      ~F"""
      <Component module={module} label="My label" class="myclass"/>
      """
    end
  end

  defmodule ViewWithPhoenixFunctionComponent do
    use Surface.LiveView

    def render(assigns) do
      module = PhoenixFunctionComponent

      ~F"""
      <Component module={module} function={:show} label="My label" class="myclass"/>
      """
    end
  end

  defmodule ViewWithNested do
    use Surface.LiveView

    def render(assigns) do
      ~F"""
      <Component module={Outer}>
        <Component module={Inner}/>
      </Component>
      """
    end
  end

  defmodule ViewWithSlotArg do
    use Surface.LiveView

    def render(assigns) do
      ~F"""
      <Component module={OuterWithSlotArg} :let={info: my_info}>
        {my_info}
      </Component>
      """
    end
  end

  defmodule StatelessWithId do
    use Surface.Component

    prop id, :string

    def render(assigns) do
      ~F"""
      <div>{@id}</div>
      """
    end
  end

  defmodule StatelessWithIdAndUpdate do
    use Surface.Component

    prop id, :string
    data id_copy, :string

    defp update(assigns) do
      assign(assigns, :id_copy, assigns.id)
    end

    @impl true
    def render(assigns) do
      assigns = update(assigns)

      ~F"""
      <div>{@id} - {@id_copy}</div>
      """
    end
  end

  defmodule ViewWithStatelessWithId do
    use Surface.LiveView

    def render(assigns) do
      module = StatelessWithId

      ~F"""
      <Component module={module} id="my_id" />
      """
    end
  end

  defmodule ViewWithStatelessWithIdAndUpdate do
    use Surface.LiveView

    def render(assigns) do
      ~F"""
      <Component module={StatelessWithIdAndUpdate} id="my_id" />
      """
    end
  end

end
