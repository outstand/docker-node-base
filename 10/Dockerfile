FROM outstand/su-exec as su-exec
FROM outstand/tini as tini
FROM outstand/fsconsul as fsconsul
FROM outstand/yarn as yarn
FROM outstand/watchman as watchman

FROM node:10
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

COPY --from=su-exec /sbin/su-exec /sbin/
COPY --from=tini /sbin/tini /sbin/
COPY --from=fsconsul /bin/fsconsul /bin/
COPY --from=yarn /bin/yarn /usr/local/bin/
COPY --from=watchman /usr/local/bin/watchman /usr/local/bin/
COPY --from=watchman /usr/local/var/run/watchman /usr/local/var/run/watchman/

RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
  && rm -rf /var/lib/apt/lists/* \
  && rm -f /usr/local/bin/yarnpkg
