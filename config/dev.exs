import Config

# Load environment variables from .env file
if File.exists?(".env") do
  for line <- File.stream!(".env") do
    line = String.trim(line)

    # Skip comments and empty lines
    if line != "" and not String.starts_with?(line, "#") do
      [key, value] = String.split(line, "=", parts: 2)
      System.put_env(String.trim(key), String.trim(value))
    end
  end
end

config :elixir_gist, ElixirGist.Repo,
  username: System.get_env("DB_USERNAME") || "backend_stuff",
  password: System.get_env("DB_PASSWORD") || "password",
  hostname: System.get_env("DB_HOSTNAME") || "localhost",
  port: String.to_integer(System.get_env("DB_PORT") || "5433"),
  database: System.get_env("DB_NAME") || "elixir_gist_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :elixir_gist, ElixirGistWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: String.to_integer(System.get_env("PORT") || "4000")],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "yo0hXXBFcYpFaGKxO/V1Hr1Z6lTJOwFukziKJtgLSoltIXRNhuAdLxbKY4xP26A0",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:elixir_gist, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:elixir_gist, ~w(--watch)]}
  ]

config :elixir_gist, ElixirGistWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/elixir_gist_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :elixir_gist, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true

config :swoosh, :api_client, false
