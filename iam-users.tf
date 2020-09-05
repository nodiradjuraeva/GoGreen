
############
# IAM users
############
module "iam_user1" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "sysadmin1"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_user2" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "sysadmin2"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_group_sysadmins" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "sysadmin"

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

module "db_user1" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "dbadmin1"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "db_user2" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "dbadmin2"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

#####################################################################################
# IAM group for DBAdmin with full Administrator access
#####################################################################################
module "iam_group_dbadmins" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "dbadmin"

  group_users = [
    module.db_user1.this_iam_user_name,
    module.db_user2.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

module "monitor_user1" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "monitor1"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "monitor_user2" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "monitor2"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "monitor_user3" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "monitor3"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "monintor_user4" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "monitor4"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}


#####################################################################################
# IAM group for Monitors with full Administrator access
#####################################################################################
module "iam_group_monitor" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam"

  name = "monitor"

  group_users = [
    module.monitor_user1.this_iam_user_name,
    module.monitor_user2.this_iam_user_name,
    module.monitor_user3.this_iam_user_name,
    module.monitor_user4.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

######################
# IAM policy (sample)
######################
data "aws_iam_policy_document" "db-full-access" {
  statement {
    actions = [
      "rds:*",
    ]

    resources = ["*"]
  }
}
