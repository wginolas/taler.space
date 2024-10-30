#!/usr/bin/env bash

set -euxo pipefail

POSTGRES_PASSWD=$(cat $POSTGRES_PASSWORD_FILE)
POSTGRES_URL=postgresql://postgres:${POSTGRES_PASSWD}@db/postgres

# TODO use ENV vars for user, host, etc.
cat >/etc/taler/secrets/exchange-db.secret.conf <<EOF
[exchangedb-postgres]
CONFIG=${POSTGRES_URL}
EOF

sleep 10  # TODO is there an other way to check if the database is running?

taler-exchange-dbinit -c /etc/taler/secrets/exchange-db.secret.conf

psql $POSTGRES_URL -c '\dt'  # TODO remove
