locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_kms_key" "encryption_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.kms_key_policy_doc.json
  enable_key_rotation     = true
  tags                    = var.tags
}

data "aws_iam_policy_document" "kms_key_policy_doc" {
  statement {
    sid     = "Enable IAM User Permissions"
    effect  = "Allow"
    actions = ["kms:*"]
    # Default key policy statement recommended by AWS KMS. It delegates access control to IAM
    # in this account and prevents the key from becoming unmanageable. In a key policy,
    # resources = ["*"] refers only to this key.
    #checkov:skip=CKV_AWS_111:Default KMS key policy root statement; required so the key stays manageable
    #checkov:skip=CKV_AWS_109:Default KMS key policy root statement; required so the key stays manageable
    #checkov:skip=CKV_AWS_356:In a key policy, "*" refers only to this key
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        var.codepipeline_role_arn
      ]
    }
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        var.codepipeline_role_arn
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}
