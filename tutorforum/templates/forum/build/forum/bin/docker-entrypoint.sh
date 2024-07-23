#!/bin/sh -e

if [ "${MONGODB_HOST#mongodb+srv://}" != "${MONGODB_HOST}" ]; then
    export MONGOHQ_URL="$MONGODB_HOST/$MONGODB_DATABASE"
else
    export MONGOHQ_URL="mongodb://$MONGODB_AUTH$MONGODB_HOST:$MONGODB_PORT/$MONGODB_DATABASE"
fi

dockerize $WAIT_MONGODB -wait $SEARCH_SERVER -wait-retry-interval 5s -timeout 600s -skip-tls-verify

exec "$@"
