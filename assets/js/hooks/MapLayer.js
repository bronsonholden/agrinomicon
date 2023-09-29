export default MapLayer = {
  mounted() {
    this.srcEl = document.getElementById(this.el.dataset.sourceId)
    this.map = $maps[this.srcEl.dataset.mapId]
    this.map.once("load", () => {
      this.map.addLayer({
        id: this.el.id,
        type: "fill",
        source: this.srcEl.id,
        layout: {},
        paint: {
          "fill-color": ["coalesce", ["get", "color"], "#0080ff"],
          "fill-opacity": 0.5
        }
      })
      this.layer = this.map.getLayer(this.el.id)
    })
  },
  destroyed() {
    this.map.removeLayer(this.layer)
  }
}
