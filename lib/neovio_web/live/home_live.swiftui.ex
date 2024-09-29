defmodule NeovioWeb.HomeLive.SwiftUI do
  use NeovioNative, [:render_component, format: :swiftui]

  def render(assigns, _interface) do
    ~LVN"""
    <Text>Hello, LiveView Native ich bins!</Text>
    """
  end
end
