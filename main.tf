resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
  enabled_policy_types = [
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

# Deny all actions outside of us-east-1 for 286812073492
resource "aws_organizations_policy" "deny_unused_regions" {
  name        = "DenyUnusedRegions"
  description = "Deny the ability to perform any actions outside of us-east-1"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scps/deny_all_outside_useast1.json")
}

# Enforce encryption on all S3 buckets
resource "aws_organizations_policy" "deny_unencrypted_buckets" {
  name        = "DenyUnencryptedBuckets"
  description = "Denies the creation of buckets without encryption enabled"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scps/deny_unencrypted_s3_buckets.json")
}

# Deny public buckets outside of 286812073492
resource "aws_organizations_policy" "deny_public_buckets" {
  name        = "DenyPublicBuckets"
  description = "Denies the creation of buckets without encryption enabled"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/scps/deny_public_buckets.json")
}