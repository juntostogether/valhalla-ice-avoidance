FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Create a wrapper script that sets ulimits before starting Valhalla
RUN echo '#!/bin/bash\n\
echo "Setting ulimits..."\n\
ulimit -n 65536\n\
ulimit -Hn 65536\n\
ulimit -Sn 65536\n\
echo "Current ulimits:"\n\
ulimit -a\n\
echo "Starting Valhalla..."\n\
exec /scripts/run.sh "$@"' > /entrypoint-wrapper.sh && \
    chmod +x /entrypoint-wrapper.sh

# Override the entrypoint
ENTRYPOINT ["/entrypoint-wrapper.sh"]