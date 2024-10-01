resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
  enabled_policy_types          = [
    "SERVICE_CONTROL_POLICY",
  ]
}

resource "aws_organizations_account" "account" {
  name  = "samuelmcmanus819"
  email = "samuel.patrick.mcmanus@gmail.com"
}

# Only allow the super admin to enable or disable regions
resource "aws_organizations_policy" "deny_region_modify_except_root" {
  name        = "DenyRegionModificationExceptSuperAdmin"
  description = "Deny the ability to enable or disable AWS regions, except for the SuperAdmin role."
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scps/superadmin_only_region_settings.json")
}