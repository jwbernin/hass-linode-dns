#!/usr/bin/with-contenv bashio

PUBLICIP=`curl -s http://ipinfo.io/ip`

LINODE_TOKEN=$(bashio::config 'apiToken')
DOMAIN=$(bashio::config 'domain')

# Get the domain ID of the domain we're interested in
DOMAINID=`curl -s -H \"Authorization: Bearer ${LINODE_TOKEN}\" https://api.linode.com/v4/domains | jq \'.data[] | select(.domain == \"${DOMAIN}\") .id\'`

echo -n DOMAINID:
echo ${DOMAINID}

#curl -H "Content-Type: application/json" \
#     -H "Authorization: Bearer $LINODE_TOKEN" \
#     -X POST -d '{
#       "type": "A",
#       "name": "$(bashio::config 'hostname')",
#       "target": "$PUBLICIP",
#       "priority": 50,
#       "ttl_sec": 604800
#     }' \
#     https://apilinode.com/v4/domains/${DOMAINID}/records

