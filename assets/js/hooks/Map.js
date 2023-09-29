import mapboxgl from "mapbox-gl"
import debounce from "debounce"

$maps = {}

export default Map = {
  mounted() {
    mapboxgl.accessToken = this.el.dataset.accessToken

    const { searchParams } = new URL(window.location)
    const ls = JSON.parse(localStorage.getItem(`camera-${this.el.id}`) || "{}")

    const camera = {
      lng: searchParams.get("lng") || ls.lng || -119.09,
      lat: searchParams.get("lat") || ls.lat || 35.26,
      zoom: searchParams.get("zoom") || ls.zoom || 9.0,
      bearing: searchParams.get("bearing") || ls.bearing || 0.00,
      pitch: searchParams.get("pitch") || ls.pitch || 0.00
    }

    this.map = new mapboxgl.Map({
      container: this.el,
      style: "mapbox://styles/mapbox/satellite-streets-v12", // mapbox://styles/bronsonholden/cljatla22003p01pzf6vt9qux"
      center: [camera.lng, camera.lat],
      zoom: camera.zoom,
      bearing: camera.bearing,
      pitch: camera.pitch
    })

    $maps[this.el.id] = this.map

    this.map.on("load", () => {
      const updateCamera = debounce((camera) => {
        localStorage.setItem(`camera-${this.el.id}`, JSON.stringify(camera))
        // TODO: Change to update_center, only pushing when camera pans
        this.pushEvent("update_camera", camera)
      }, 300)

      // Update camera initially loaded via local storage or query params
      this.pushEvent("update_camera", camera)

      const listener = () => {
        const { lng, lat } = this.map.getCenter()
        const zoom = this.map.getZoom()
        const bearing = this.map.getBearing()
        const pitch = this.map.getPitch()
        const camera = {
          lat: lat.toFixed(5),
          lng: lng.toFixed(5),
          zoom: zoom.toFixed(2),
          pitch: pitch.toFixed(2),
          bearing: bearing.toFixed(2)
        }
        updateCamera(camera)
      }

      this.map
        .on("move", listener)
        .once("remove", () => {
          this.map.off("move", listener)
        })
    })
  },
  destroyed() {
    this.map.remove()
  }
}
