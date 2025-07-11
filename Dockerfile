FROM ghcr.io/gis-ops/docker-valhalla/valhalla:latest

# Increase ulimits at system level
RUN echo "* soft nofile 65536" >> /etc/security/limits.conf && \
    echo "* hard nofile 65536" >> /etc/security/limits.conf && \
    echo "fs.file-max = 65536" >> /etc/sysctl.conf

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