# Agrinomicon

1. Install PostgreSQL and PostGIS
2. Run `mix setup` to install and setup dependencies
3. Create a `dev.secret.exs` file in the `config/` directory with the following:

     ```ex
     config :agrinomicon,
            :mapbox_access_token
            "<paste Mapbox token here>"
     ```
4. Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
