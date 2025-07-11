FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Create wrapper script that sets ulimits and calls the original entrypoint
RUN echo '#!/bin/bash\n\
echo "Setting ulimits..."\n\
ulimit -n 65536\n\
ulimit -Hn 65536\n\
ulimit -Sn 65536\n\
echo "Current ulimits:"\n\
ulimit -a\n\
echo "Starting Valhalla..."\n\
exec /entrypoint.sh "$@"' > /tmp/entrypoint-wrapper.sh && \
    chmod +x /tmp/entrypoint-wrapper.sh

ENTRYPOINT ["/tmp/entrypoint-wrapper.sh"]