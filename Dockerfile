FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Just set ulimits in a startup script
RUN echo '#!/bin/bash\n\
ulimit -n 65536\n\
exec /scripts/run.sh' > /custom-entrypoint.sh && \
    chmod +x /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]