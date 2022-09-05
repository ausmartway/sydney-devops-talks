project = "sydney-devops-talks"

app "example-nodejs" {
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
  }

  deploy {
    use "docker" {}
  }
}

app "ecs-nodejs-web" {
  labels = {
    "service" = "ecs-nodejs-web",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    registry {
      use "aws-ecr" {
        region     = "ap-southeast-2"
        repository = "sydney-devops-talks"
        tag        = "latest"
      }
    }
  }

  deploy {
    use "aws-ecs" {
      region = "ap-southeast-2"
      cluster = "sydney-devops-talk"
      memory = "512"
      count = 1
      architecture = "ARM64"
    }
  }
}
