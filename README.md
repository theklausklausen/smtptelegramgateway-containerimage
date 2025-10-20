# SMTP Telegram Gateway – Docker Image Builder

This repository builds and publishes a Docker image for the [`SmtpTelegramGateway`](https://github.com/7orlum/SmtpTelegramGateway) project, which acts as a gateway to forward SMTP emails to a Telegram chat.

## 📦 About

The image is automatically built and pushed to the **GitHub Container Registry (GHCR)**:

- On every commit to the `main` branch
- On a daily schedule via GitHub Actions

The image includes the latest version of [`7orlum/SmtpTelegramGateway`](https://github.com/7orlum/SmtpTelegramGateway), containerized for easy deployment.

## 🐳 Docker Image

The built image is available at:

ghcr.io/theklausklausen/smtp-telegram-gateway

Tags:

- `latest` – latest successful build from `main`
- `<commit>` – short commit SHA # RODO

## ⚙️ GitHub Actions CI

This repo uses a GitHub Actions workflow to:

1. Check out the code
2. Build the Docker image from the source
3. Push the image to GHCR

Trigger conditions:

- `on: push` to `main`
- `on: schedule` (daily at midnight UTC)

See [`.github/workflows/docker-publish.yml`](.github/workflows/docker-publish.yml) for details.

## 🧪 Usage

Once published, you can run the container like this:

```yaml
services:
  smtptelegramgateway:
    image: ghcr.io/theklausklausen/smtp-telegram-gateway:latest
    container_name: smtptelegramgateway
    restart: unless-stopped
    ports:
      - "25:25"
    volumes:
      - ./config:/etc/smtptelegramgateway:ro
```

Example config:

```yaml
# The port that the gateway will listen on to receive SMTP e-mail messages, the default is 25. 
# No authorization is required when connecting to this port, select Basic Authorizathion if it is required
SmtpPort: 25
# Your token for the Telegram bot, get it at https://t.me/BotFather when registering the bot
TelegramBotToken: SPECIFY THERE TELEGRAM BOT TOKEN
# Define here a list of email addresses and telegram chats that will receive emails sent to these addresses.
# Use an asterisk "*" instead of an email address to send all emails to some telegram chat
# If you specify a Telegram user chat, the user must be subscribed to the bot
# If you specify a Telegram group chat, you may need to add a minus sign prior to the group id, the bot must be added to the group
# If you specify a Telegram channel chat, you may need to add -100 prior to the channel id, the bot must be added to the channel admins and given the right "Post in the channel"
# For public channel chat, you can specify the channel public @username instead of the channel id
Routing:
-   Email: "*"
    TelegramChat: SPECIFY THERE TELEGRAM USERID, GROUPID, CHANNELID OR @USERNAME
-   Email: example@test.com
    TelegramChat: SPECIFY THERE TELEGRAM USERID, GROUPID, CHANNELID OR @USERNAME
# Logging Level. Set to Debug to see the details of the communication between your mail program and the gateway.
# Set to Error to see less information
Logging:
  LogLevel:
    Default: Debug
```

Environment variables and options should match the upstream project's configuration.

🔗 Upstream Project

This image is based on the open-source project:

👉 `7orlum/SmtpTelegramGateway`

All credits go to the original author.

📝 License

This repository only builds and distributes a Docker image based on the upstream project. See the original license
for usage terms.
