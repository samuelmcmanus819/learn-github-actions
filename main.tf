resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "account" {
  name  = "samuelmcmanus819"
  email = "samuel.patrick.mcmanus@gmail.com"
}