FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Create wrapper script in /tmp where we have write permissions
RUN echo '#!/bin/bash\n\
echo "Setting ulimits..."\n\
ulimit -n 65536\n\
ulimit -Hn 65536\n\
ulimit -Sn 65536\n\
echo "Current ulimits:"\n\
ulimit -a\n\
echo "Starting Valhalla..."\n\
exec /scripts/run.sh "$@"' > /tmp/entrypoint-wrapper.sh && \
    chmod +x /tmp/entrypoint-wrapper.sh

# Override the entrypoint
ENTRYPOINT ["/tmp/entrypoint-wrapper.sh"]