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
    env:
      SmtpPort=25
      TelegramBotToken=111__ABC
      Routing__0__Email=*
      Routing__0__TelegramChat=222
      Logging__LogLevel__Default=Debug
```

The config can be referenced [here](https://github.com/7orlum/SmtpTelegramGateway?tab=readme-ov-file#other-configure-options).

Environment variables and options should match the upstream project's configuration.

🔗 Upstream Project

This image is based on the open-source project:

👉 `7orlum/SmtpTelegramGateway`

All credits go to the original author.

📝 License

This repository only builds and distributes a Docker image based on the upstream project. See the original license
for usage terms.
