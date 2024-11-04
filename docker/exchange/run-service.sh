#!/usr/bin/env bash

set -euxo pipefail

POSTGRES_PASSWD=$(cat $POSTGRES_PASSWORD_FILE)
POSTGRES_URL=postgresql://postgres:${POSTGRES_PASSWD}@db/postgres

# TODO use ENV vars for user, host, etc.
cat >/etc/taler/secrets/exchange-db.secret.conf <<EOF
[exchangedb-postgres]
CONFIG=${POSTGRES_URL}
EOF

# sleep 10  # TODO is there an other way to check if the database is running?

taler-exchange-dbinit -c /etc/taler/secrets/exchange-db.secret.conf
# psql $POSTGRES_URL -c '\dt'  # TODO remove

if [ ! -f /etc/taler/conf.d/exchange-coins.conf ]; then
    taler-harness deployment gen-coin-config --min-amount TAUSCHY:0.01 --max-amount TAUSCHY:100 > /etc/taler/conf.d/exchange-coins.conf
fi

sed -i 's/#currency = KUDOS/currency = TAUSCHY/g' /etc/taler/taler.conf
sed -i 's/#currency_round_unit = KUDOS:0.01/currency_round_unit = TAUSCHY:0.01/g' /etc/taler/taler.conf

cat /etc/taler/taler.conf
