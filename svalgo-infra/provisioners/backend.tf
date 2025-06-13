terraform {
  backend "s3" {
    use_lockfile = true
    region       = "us-east-1"
  }
}
