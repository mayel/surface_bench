defmodule SurfaceBenchWeb.BenchmarkTest do
  use SurfaceBenchWeb.ConnCase, async: true

  test "benchmark" do
    SurfaceBenchWeb.Benchmark.run()
  end

end
