# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Agrinomicon.Repo.insert!(%Agrinomicon.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Zea",
  species: "Mays",
  binomial_name: "Zea mays",
  aliases: [],
  common_names: ["corn"],
  cdl_value: "1",
  geometry_color: "FFD400"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Glycine",
  species: "Max",
  binomial_name: "Glycine max",
  aliases: [],
  common_names: ["soybean"],
  cdl_value: "5",
  geometry_color: "267300"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Vitis",
  species: "Vinifera",
  binomial_name: "Vitis vinifera",
  aliases: [],
  common_names: ["table grape"],
  cdl_value: "704489",
  geometry_color: "704489"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Citrus",
  species: "C. × sinensis",
  binomial_name: "Citrus × sinensis",
  aliases: ["Citrus sinensis"],
  common_names: ["orange"],
  cdl_value: "212",
  geometry_color: "E67525"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Prunus",
  species: "Avium",
  binomial_name: "Prunus avium",
  aliases: [],
  common_names: ["cherry"],
  cdl_value: "66",
  geometry_color: "FF00FF"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Prunus",
  species: "Dulcis",
  binomial_name: "Prunus dulcis",
  aliases: [],
  common_names: ["almond"],
  cdl_value: "75",
  geometry_color: "00A884"
})

Agrinomicon.Repo.insert!(%Agrinomicon.Agency.Organization{
  name: "ACME Growers, Inc."
})
