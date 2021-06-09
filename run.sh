#!/usr/bin/with-contenv bashio

PUBLICIP=`curl -s http://ipinfo.io/ip`

bashio::log.info "Public IP: ${PUBLICIP}"

LINODE_TOKEN=$(bashio::config 'apiToken')
DOMAIN=$(bashio::config 'domain')
HOSTNAME=$(bashio::config 'hostname')

bashio::log.info "Searching for domain: ${DOMAIN}"

# Get the domain ID of the domain we're interested in
DOMAINID=`curl -s -H "Authorization: Bearer ${LINODE_TOKEN}" https://api.linode.com/v4/domains | jq ".data[] | select(.domain == \"${DOMAIN}\") .id"`

if [[ -z $DOMAINID ]]; then
  bashio::log.error "Error: Domain $DOMAIN not found in linode API."
  exit 1
fi

bashio::log.info "Found domain ID: ${DOMAINID}"

bashio::log.info "Going to create host record."

curl -s \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $LINODE_TOKEN" \
     -X POST -d "{
       \"type\": \"A\",
       \"name\": \"$HOSTNAME\",
       \"target\": \"$PUBLICIP\",
       \"priority\": 50,
       \"ttl_sec\": 604800
     }" \
     https://api.linode.com/v4/domains/${DOMAINID}/records

