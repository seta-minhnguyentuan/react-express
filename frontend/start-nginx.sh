#!/bin/sh

# Create nginx.conf from template by substituting environment variables
envsubst '${BACKEND_HOST} ${BACKEND_PORT}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf

# Start nginx
exec nginx -g 'daemon off;'
