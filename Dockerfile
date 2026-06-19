FROM alpine:latest
ENV PORT=8080

RUN apk update && apk add --no-cache xray nginx bash ca-certificates

COPY config.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE ${PORT}
CMD ["/entrypoint.sh"]
