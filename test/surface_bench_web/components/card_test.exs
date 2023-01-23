defmodule SurfaceBenchWeb.Components.CardTest do
  use SurfaceBenchWeb.ConnCase, async: true
  use Surface.LiveViewTest

  catalogue_test SurfaceBenchWeb.Card
end
