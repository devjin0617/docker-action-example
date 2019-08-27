workflow "Start Action" {
  resolves = ["GitHub Action for Docker"]
  on = "pull_request"
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@fe7ed3ce992160973df86480b83a2f8ed581cd50"
  args = "build -t docker-action-example ."
}
