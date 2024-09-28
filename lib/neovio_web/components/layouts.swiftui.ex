defmodule NeovioWeb.Layouts.SwiftUI do
  use NeovioNative, [:layout, format: :swiftui]

  embed_templates "layouts_swiftui/*"
end
