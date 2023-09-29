import MapboxDraw from "@mapbox/mapbox-gl-draw"
import { DRAW_STYLES } from "../util"

export default {
  mounted() {
    this.map = $maps[this.el.dataset.mapId]

    this.draw = new MapboxDraw({
      styles: DRAW_STYLES,
      controls: {
        polygon: true,
        combine_features: true,
        uncombine_features: true,
        trash: true
      },
      userProperties: true
    })

    this.map.addControl(this.draw)

    this.map.on("draw.create", ({ features }) => {
      this.pushEvent("create_blocks", { features }, (reply, _ref) => {
        features.forEach((feature, index) => {
          const drawFeature = this.draw.get(feature.id)

          this.draw.delete(feature.id)
          this.draw.add({ ...drawFeature, id: reply.block_ids[index] })
        })
      })
    })

    this.map.on("draw.update", ({ features: _features, action: _action }) => {
    })

    this.map.on("draw.delete", ({ features }) => {
      this.pushEvent("delete_blocks", { block_ids: features.map(({ id }) => id) })
    })

    this.map.on("draw.combine", ({
      deletedFeatures: _deletedFeatures,
      createdFeatures: _createdFeatures
    }) => {
    })

    this.map.on("draw.uncombine", ({
      deletedFeatures: _deletedFeatures,
      createdFeatures: _createdFeatures
    }) => {
    })

    this.handleEvent("insert_features", ({ features }) => {
      if (this.draw.getMode() !== "simple_select") return

      const featureIds = features.map(({ id }) => id)

      // deleting and readding ensures we render with correct property-based style
      this.draw.delete(featureIds)
      this.draw.add({
        features,
        type: "FeatureCollection"
      })
    })

    this.handleEvent("put_features", ({ features }) => {
      if (this.draw.getMode() !== "simple_select") return

      this.draw.set({
        features,
        type: "FeatureCollection"
      })
    })

    this.handleEvent("remove_features", ({ features }) => {
      features.forEach((feature) => {
        this.draw.delete(feature.id)
      })
    })
  },

  destroyed() {
    this.map.removeControl(this.draw)
  }
}
