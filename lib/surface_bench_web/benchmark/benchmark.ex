defmodule SurfaceBenchWeb.Benchmark do
  import Phoenix.ConnTest

  @endpoint SurfaceBenchWeb.Endpoint
  @session %{names: ["chris", "jose"], from: nil}

  def run do
    Logger.configure(level: :info)
    conn = build_conn()
    |> init_test_session(@session)

    Benchee.run(
      %{

        "LiveView/FunctionComponent/WithComponentLive" => fn -> get(conn, "/LiveView/FunctionComponent/WithComponentLive") end,
        "LiveView/FunctionComponent/WithMultipleTargets" => fn -> get(conn, "/LiveView/FunctionComponent/WithMultipleTargets") end,
        
        "LiveView/ComponentAndNestedInLive" => fn -> get(conn, "/LiveView/ComponentAndNestedInLive/NestedLive") end,

        "LiveView/ComponentInLive/Root" => fn -> get(conn, "/LiveView/ComponentInLive/Root") end,
        "LiveView/ComponentInLive/Live" => fn -> get(conn, "/LiveView/ComponentInLive/Live") end,

        "Components/ViewWithStateless" => fn -> get(conn, "/Components/ViewWithStateless") end,
        "Components/ViewWithNested" => fn -> get(conn, "/Components/ViewWithNested") end,
        "Components/ViewWithSlotArg" => fn -> get(conn, "/Components/ViewWithSlotArg") end,
        "Components/ViewWithStatelessWithId" => fn -> get(conn, "/Components/ViewWithStatelessWithId") end,
        "Components/ViewWithStatelessWithIdAndUpdate" => fn -> get(conn, "/Components/ViewWithStatelessWithIdAndUpdate") end,

        "LiveComponents/View" => fn -> get(conn, "/LiveComponents/View") end,

        "Dynamic/Components/ViewWithStateless" => fn -> get(conn, "/Dynamic/Components/ViewWithStateless") end,
        "Dynamic/Components/ViewWithPhoenixFunctionComponent" => fn -> get(conn, "/Dynamic/Components/ViewWithPhoenixFunctionComponent") end,
        "Dynamic/Components/ViewWithNested" => fn -> get(conn, "/Dynamic/Components/ViewWithNested") end,
        "Dynamic/Components/ViewWithSlotArg" => fn -> get(conn, "/Dynamic/Components/ViewWithSlotArg") end,
        "Dynamic/Components/ViewWithStatelessWithIdAndUpdate" => fn -> get(conn, "/Dynamic/Components/ViewWithStatelessWithIdAndUpdate") end,

        "Dynamic/LiveComponents/View" => fn -> get(conn, "/Dynamic/LiveComponents/View") end,
        "Dynamic/LiveComponents/ViewWithPhoenixLiveComponent" => fn -> get(conn, "/Dynamic/LiveComponents/ViewWithPhoenixLiveComponent") end,
        "Dynamic/LiveComponents/ViewWithInnerContent" => fn -> get(conn, "/Dynamic/LiveComponents/ViewWithInnerContent") end,

      },
      parallel: 1,
      warmup: 2,
      time: 5,
      memory_time: 2,
      reduction_time: 2,
      profile_after: true,
      formatters: [
        {
          Benchee.Formatters.HTML,
          [
            file: "benchmarks/output/components.html"
          ]
        },
        Benchee.Formatters.Console
      ]
    )

    Logger.configure(level: :debug)
  end
end