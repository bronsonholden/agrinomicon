# Agrinomicon

1. Install PostgreSQL and PostGIS
2. Run `mix setup` to install and setup dependencies
3. Create a `dev.secret.exs` file in the `config/` directory with the following:

     ```ex
     config :agrinomicon,
            :mapbox_access_token,
            "<paste Mapbox token here>"
     ```
4. Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`


# About

Agrinomicon was an idea I had for a long time that was inspired by a lot of
different tools I had worked with while employed at Stria. We built and/or managed
many different tech solutions for farm managers or ag companies.

My greatest interest was in building a library of data around US agriculture: what crops
were planted where, what annual yields were, etc. Agriculture is obviously a huge industry
so the scope was large, and I eventually settled on a making it a neat tool that let you
draw polygons on a satellite map, and it would query USDA crop production databases to
find out what was planted there. They maintain a rich and pretty accurate record of
crop plantings (I think primarily it's generated with satellite imagery, which itself is
pretty cool), so I had begun working on generating polygon maps from the data, but the
API queries were complex and it got tricky if a single field lay across the query boundary.

It was a fun exercise and let me learn a good bit about ag and geographic applications.
