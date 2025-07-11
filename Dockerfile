FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Create a wrapper script that sets ulimits before starting Valhalla
RUN echo '#!/bin/bash\nulimit -n 65536\nulimit -u 32768\nexec /scripts/run.sh "$@"' > /valhalla-wrapper.sh && \
    chmod +x /valhalla-wrapper.sh

ENTRYPOINT ["/valhalla-wrapper.sh"]