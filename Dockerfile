FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# First, let's see what's actually in the image
RUN echo '#!/bin/bash\n\
echo "Setting ulimits..."\n\
ulimit -n 65536\n\
echo "Current ulimits:"\n\
ulimit -a\n\
echo "Looking for startup scripts..."\n\
ls -la / | grep -E "(entrypoint|run|start)"\n\
ls -la /scripts/ 2>/dev/null || echo "No /scripts directory"\n\
ls -la /usr/local/bin/ | grep -E "(valhalla|run|start)"\n\
echo "Starting Valhalla the default way..."\n\
# Just run the default command\n\
exec "$@"' > /tmp/entrypoint-wrapper.sh && \
    chmod +x /tmp/entrypoint-wrapper.sh

ENTRYPOINT ["/tmp/entrypoint-wrapper.sh"]
# Let the base image CMD run