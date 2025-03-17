# Ignoring the volumes they use in the compose spec. One of them seems to be to cache the typst
# binary, but that seems fine to re-download every time the instance restarts. The other is for some
# 'tag' thing but I have absolutely no idea what that is.

job "typst-bot" {
  type = "service"

  group "typst-bot" {
    task "typst-bot" {
      driver = "docker"

      config {
        image = var.image_tag
      }

      template {
        data        = <<ENV
{{ with nomadVar "nomad/jobs/typst-bot" }}
DISCORD_TOKEN={{ .bot_token }}
{{ end }}
ENV
        destination = "local/.env"
        env         = true
      }
    }
  }
}

variable "image_tag" {
  type = string
  default = "ghcr.io/datasektionen/typst-bot:latest"
}
