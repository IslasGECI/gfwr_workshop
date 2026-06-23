mexico_region <- gfwr::gfw_region_id(
    region = "Mexico",
    region_source = "EEZ"
)

mexico_id <- mexico_region[["id"]]

start_date <- "2014-01-19"
end_date <- "2014-06-30"

mexico_fisheff <- gfwr::gfw_ais_fishing_hours(
    spatial_resolution = "LOW",
    temporal_resolution = "MONTHLY",
    start_date = start_date,
    end_date = end_date,
    region = mexico_id,
    region_source = "EEZ")

map_effort_light <- c("#ffffff", "#eeff00", "#3b9088","#0c276c")

png(filename="apparent_fishing_effor_eez_mexico.png")

mexico_fisheff |>
  dplyr::filter(`Apparent Fishing Hours` > 0) |>
  ggplot2::ggplot() +
  ggplot2::geom_tile(
    ggplot2::aes(x = Lon,
        y = Lat,
        fill = `Apparent Fishing Hours`)) +
  ggplot2::geom_sf(data = rnaturalearth::ne_countries(returnclass = "sf", scale = "medium")) +
  ggplot2::coord_sf(xlim = c(-119, -86), ylim = c(33, 13)) +
  ggplot2::scale_fill_gradientn(
    trans = 'log10',
    colors = map_effort_light,
    na.value = NA,
    labels = scales::comma) +
  ggplot2::labs(title = "Esfuerzo pesquero aparente en la ZEE de México",
       subtitle = glue::glue("{start_date} a {end_date}"),
       fill = "Fishing hours")

dev.off()


US_in_MEX <- gfwr::gfw_ais_fishing_hours(
    spatial_resolution = "LOW",
    temporal_resolution = "MONTHLY",
    start_date = start_date,
    end_date = end_date,
    group_by = "VESSEL_ID",
    filter_by = "flag IN ('USA')",
    region = mexico_id,
    region_source = "EEZ")

