FROM valhalla/valhalla:run-latest

ENV VALHALLA_SERVICE_LIMITS='{"max_exclude_polygons": 50}'
ENV VALHALLA_LOG_LEVEL=INFO