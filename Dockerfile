FROM valhalla/valhalla:build-latest

# Install necessary tools
RUN apt-get update && apt-get install -y wget curl

# Create the build script
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Starting Valhalla setup..."\n\
\n\
# Download OSM data\n\
if [ ! -f /data/northern-california.osm.pbf ]; then\n\
  echo "Downloading Northern California OSM data..."\n\
  wget -O /data/northern-california.osm.pbf https://download.geofabrik.de/north-america/us/california/norcal-latest.osm.pbf\n\
fi\n\
\n\
# Build config\n\
echo "Building Valhalla config..."\n\
valhalla_build_config \\\n\
  --mjolnir-tile-dir /data/valhalla \\\n\
  --mjolnir-max-cache-size 1000000000 \\\n\
  > /data/valhalla.json\n\
\n\
# Build tiles with limited concurrency\n\
echo "Building tiles (this will take 20-30 minutes)..."\n\
valhalla_build_tiles -c /data/valhalla.json -j 2 /data/northern-california.osm.pbf\n\
\n\
# Start service\n\
echo "Starting Valhalla service..."\n\
valhalla_service /data/valhalla.json 1\n\
' > /start.sh && chmod +x /start.sh

# Set working directory
WORKDIR /data

# Run the script
CMD ["/start.sh"]