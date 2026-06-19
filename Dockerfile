FROM alpine:3.20

ENV XRAY_VERSION=1.8.24

RUN apk update --no-cache && apk add --no-cache \
    nginx wget unzip ca-certificates tzdata

RUN wget -qO /xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip /xray.zip -d /usr/local/bin/ && rm /xray.zip && \
    chmod +x /usr/local/bin/xray

RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/http.d/*

COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD sh -c "nginx -g 'daemon off;' & xray run -c /etc/xray/config.json"
