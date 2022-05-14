ARG OFFEN_BACKUP_VERSION=v2.12.0
ARG INFLUXDB_VERSION=2.2.0

FROM offen/docker-volume-backup:${OFFEN_BACKUP_VERSION} AS base
FROM influxdb:${INFLUXDB_VERSION}-alpine AS influxdb

COPY --from=base /usr/bin/backup /usr/bin/backup
COPY docker-entrypoint.sh backup.sh /
RUN chmod +x /docker-entrypoint.sh /backup.sh \
    && mkdir /pre.d \
    && mkdir /post.d

ENTRYPOINT ["/docker-entrypoint.sh"]
