#!/bin/sh

set -e

sed -i 's|#include = \x27\x27|include \x27/etc/postgresql/pg_similarity.conf\x27|' /var/lib/postgresql/data/postgresql.conf

export PGUSER="$POSTGRES_USER"

"${psql[@]}" --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE EXTENSION IF NOT EXISTS pg_similarity;
EOSQL