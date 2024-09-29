defmodule NeovioWeb.HomeLive do
  use NeovioWeb, :live_view
  use NeovioNative, :live_view

  def render(assigns) do
    ~H"""
    <p>Hello, LiveView Native ich bins!</p>
    """
  end
end
