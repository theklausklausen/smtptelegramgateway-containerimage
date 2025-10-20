FROM debian:12.12-slim AS builder
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    unzip \
    ca-certificates \
    jq
RUN export LATEST=$(curl -s https://api.github.com/repos/7orlum/SmtpTelegramGateway/releases/latest | jq -r .tag_name) && \
    wget https://github.com/7orlum/SmtpTelegramGateway/releases/download/${LATEST}/SmtpTelegramGateway.${LATEST}.linux-x64.zip && \
    unzip SmtpTelegramGateway.${LATEST}.linux-x64.zip && \
    chmod +x linux-x64/SmtpTelegramGateway

FROM debian:12.12-slim AS runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    libicu72 && \
    mkdir -p /usr/local/bin/SmtpTelegramGateway/
COPY --from=builder /linux-x64/* /usr/local/bin/SmtpTelegramGateway/
RUN mkdir -p /etc/smtptelegramgateway/ && \
    mv /usr/local/bin/SmtpTelegramGateway/appsettings.yaml /etc/smtptelegramgateway/appsettings.yaml && \
    ln -s /etc/smtptelegramgateway/appsettings.yaml /usr/local/bin/SmtpTelegramGateway/appsettings.yaml
VOLUME [ "/etc/smtptelegramgateway/" ]
ENTRYPOINT [ "sh", "-c", "cp /etc/smtptelegramgateway/appsettings.yaml /usr/local/bin/SmtpTelegramGateway/appsettings.yaml && /usr/local/bin/SmtpTelegramGateway/SmtpTelegramGateway" ]