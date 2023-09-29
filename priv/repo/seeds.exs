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
  genus: "Vitis",
  species: "Vinifera",
  binomial_name: "Vitis vinifera",
  aliases: [],
  common_names: ["table grape"]
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Citrus",
  species: "C. × sinensis",
  binomial_name: "Citrus × sinensis",
  aliases: ["Citrus sinensis"],
  common_names: ["orange"]
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Prunus",
  species: "Avium",
  binomial_name: "Prunus avium",
  aliases: [],
  common_names: ["cherry"]
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Prunus",
  species: "Cerasus",
  binomial_name: "Prunus cerasus",
  aliases: [],
  common_names: ["cherry"]
})

Agrinomicon.Repo.insert!(%Agrinomicon.Taxonomy.Classification{
  kingdom: :plantae,
  genus: "Prunus",
  species: "Dulcis",
  binomial_name: "Prunus dulcis",
  aliases: [],
  common_names: ["almond"]
})

Agrinomicon.Repo.insert!(%Agrinomicon.Agency.Organization{
  name: "ACME Growers, Inc."
})
