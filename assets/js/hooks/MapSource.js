export default MapSource = {
  mounted() {
    this.map = $maps[this.el.dataset.mapId]

    this.map.once("load", () => {
      this.map.addSource(this.el.id, {
        type: "geojson",
        data: this.getSourceData()
      })
      this.source = this.map.getSource(this.el.id)
      this.updateSource()
    })
  },
  destroyed() {
    this.map.removeSource(this.source)
  },
  updated() {
    this.updateSource(this.getSourceData())
  },
  getSourceData() {
    const children = Array.from(this.el.children)
    const features = children.map((child) => JSON.parse(child.dataset.feature))
    return {
      features,
      type: "FeatureCollection"
    }
  },
  updateSource() {
    const collection = this.getSourceData()
    this.source.setData(collection)
  }
}
