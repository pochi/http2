defmodule Http2.Mixfile do
  use Mix.Project

  def project do
    [app: :http2,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: "HTTP2 Client for Elixir",
     package: [
       contributors: ["pochi"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/pochi/http2"}
     ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
