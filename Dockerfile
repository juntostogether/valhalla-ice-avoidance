FROM valhalla/valhalla:build-latest

RUN apt-get update && apt-get install -y wget curl

RUN echo '#!/bin/bash\n\
set -e\n\
echo "Starting Valhalla setup..."\n\
echo "Checking available commands..."\n\
which valhalla_build_config || echo "valhalla_build_config not in PATH"\n\
find / -name "valhalla_build_config" 2>/dev/null || echo "Cannot find valhalla_build_config"\n\
ls -la /usr/local/bin/ | grep valhalla || echo "No valhalla binaries in /usr/local/bin"\n\
ls -la /usr/bin/ | grep valhalla || echo "No valhalla binaries in /usr/bin"\n\
echo "PATH is: $PATH"\n\
' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]