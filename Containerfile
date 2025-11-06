FROM debian:13.1-slim AS builder
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

FROM debian:13.1-slim AS runtime
RUN apt-get update && apt-get install -y --no-install-recommends \
    libicu76 \
    ca-certificates \
    libssl3 && \
    update-ca-certificates
COPY --from=builder /linux-x64/SmtpTelegramGateway /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/SmtpTelegramGateway" ]