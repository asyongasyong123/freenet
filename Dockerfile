FROM alpine:latest

ENV XRAY_VERSION=1.8.24

# Install packages
RUN apk update && apk add --no-cache \
    nginx wget unzip ca-certificates tzdata

# Install Xray
RUN wget -qO /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && rm /tmp/xray.zip && \
    chmod +x /usr/local/bin/xray

# Clear default configs
RUN rm -rf /etc/nginx/conf.d/* /etc/nginx/http.d/*

# Copy our configs
COPY xray.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf

# Exact port Cloud Run uses
EXPOSE 8080

# Start both services properly
CMD sh -c "nginx -g 'daemon off;' & xray run -c /etc/xray/config.json"
