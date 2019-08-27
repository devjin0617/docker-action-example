workflow "Start Action" {
  on = "pull_request"
  resolves = ["GitHub Action for Docker-2"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  args = "build -t docker-action-example ."
}

action "GitHub Action for AWS" {
  uses = "actions/aws/cli@efb074ae4510f2d12c7801e4461b65bf5e8317e6"
  needs = ["GitHub Action for Docker"]
  secrets = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
  args = "aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION | sh"
  env = {
    AWS_DEFAULT_REGION = "ap-northeast-2"
  }
}

action "GitHub Action for Docker-1" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  needs = ["GitHub Action for AWS"]
  args = "tag docker-test:latest 660261524637.dkr.ecr.ap-northeast-2.amazonaws.com/docker-test:latest"
}

action "GitHub Action for Docker-2" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  needs = ["GitHub Action for Docker-1"]
  args = "push 660261524637.dkr.ecr.ap-northeast-2.amazonaws.com/docker-test:latest"
}
