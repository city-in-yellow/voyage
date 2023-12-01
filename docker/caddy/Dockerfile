FROM caddy:2.7.5-builder AS builder

RUN xcaddy build \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/enum-gg/caddy-discord

FROM caddy:2.7.5-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add --no-cache tini
COPY signal-handler.sh /
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/signal-handler.sh", "caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
