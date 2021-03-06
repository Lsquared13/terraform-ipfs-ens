# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH WRITE LAMBDA LOGS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "lambda_allow_write_cloudwatch_logs" {
    name = "lambda-allow-write-logs-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.lambda_allow_write_cloudwatch_logs.json
  }

  data "aws_iam_policy_document" "lambda_allow_write_cloudwatch_logs" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
      ]
      resources = ["arn:aws:logs:*:*:*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# ASSUME ROLE LAMBDA POLICY DOCUMENT
# ---------------------------------------------------------------------------------------------------------------------

  data "aws_iam_policy_document" "lambda_assume_role" {
    version = "2012-10-17"

    statement {
      sid = "AllowLambdaAssume"

      effect = "Allow"

      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }

  }

  data "aws_iam_policy_document" "codepipeline_assume_role" {
    version = "2012-10-17"

    statement {
      sid = "AllowCodePipelineAssume"

      effect = "Allow"

      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["codepipeline.amazonaws.com"]
      }
    }

    statement {
      sid = "AllowCodeBuildAssume"

      effect = "Allow"

      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["codebuild.amazonaws.com"]
      }
    }
  }

  data "aws_iam_policy_document" "api_gateway_assume_role" {
    version = "2012-10-17"

    statement {
      sid = "AllowAPIGatewayAssume"

      effect = "Allow"

      actions = ["sts:AssumeRole"]
      principals {
        type  = "Service"
        identifiers = ["apigateway.amazonaws.com"]
      }
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB DEPLOYMENTS TABLE READ/WRITE ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_deployments_table_read_write" {
    name = "dynamodb-deployments-table-read-write-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_deployments_table_read_write.json
  }

  data "aws_iam_policy_document" "dynamodb_deployments_table_read_write" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.deployments_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Query"
      ]

      resources = [
        aws_dynamodb_table.deployments_table.arn,
        "${aws_dynamodb_table.deployments_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB DEPLOYMENTS TABLE READ ONLY ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_deployments_table_read_only" {
    name = "dynamodb-deployments-table-read-only-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_deployments_table_read_only.json
  }

  data "aws_iam_policy_document" "dynamodb_deployments_table_read_only" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.deployments_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query"
      ]

      resources = [
        aws_dynamodb_table.deployments_table.arn,
        "${aws_dynamodb_table.deployments_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB USERS TABLE READ/WRITE ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_users_table_read_write" {
    name = "dynamodb-users-table-read-write-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_users_table_read_write.json
  }

  data "aws_iam_policy_document" "dynamodb_users_table_read_write" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.users_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Query",
      ]

      resources = [
        aws_dynamodb_table.users_table.arn,
        "${aws_dynamodb_table.users_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB USERS TABLE READ ONLY ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_users_table_read_only" {
    name = "dynamodb-users-table-read-only-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_users_table_read_only.json
  }

  data "aws_iam_policy_document" "dynamodb_users_table_read_only" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.users_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
      ]

      resources = [
        aws_dynamodb_table.users_table.arn,
        "${aws_dynamodb_table.users_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB NONCE TABLE READ/WRITE ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_nonce_table_read_write" {
    name = "dynamodb-nonce-table-read-write-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_nonce_table_read_write.json
  }

  data "aws_iam_policy_document" "dynamodb_nonce_table_read_write" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.nonce_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Query",
      ]

      resources = [
        aws_dynamodb_table.nonce_table.arn,
        "${aws_dynamodb_table.nonce_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# DYNAMODB NONCE TABLE READ ONLY ACCESS
# ---------------------------------------------------------------------------------------------------------------------

  resource "aws_iam_policy" "dynamodb_nonce_table_read_only" {
    name = "dynamodb-nonce-table-read-only-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.dynamodb_nonce_table_read_only.json
  }

  data "aws_iam_policy_document" "dynamodb_nonce_table_read_only" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "dynamodb:DescribeTable",
      ]

      resources = [aws_dynamodb_table.nonce_table.arn]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
      ]

      resources = [
        aws_dynamodb_table.nonce_table.arn,
        "${aws_dynamodb_table.nonce_table.arn}/*",
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# SQS SEND MESSAGES
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "sqs_send_message_ipfs_ens" {
    name = "sqs-send-message-ipfs-ens-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.sqs_send_message_ipfs_ens.json
  }

  data "aws_iam_policy_document" "sqs_send_message_ipfs_ens" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "sqs:SendMessage",
      ]

      resources = [aws_sqs_queue.ens_deploy_queue.arn]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# SQS CONSUME MESSAGES
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "sqs_consume_message_ipfs_ens" {
    name = "sqs-consume-message-ipfs-ens-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.sqs_consume_message_ipfs_ens.json
  }

  data "aws_iam_policy_document" "sqs_consume_message_ipfs_ens" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ChangeMessageVisibility",
      ]
      resources = [
        aws_sqs_queue.ens_deploy_queue.arn,
        aws_sqs_queue.ens_deploy_queue_deadletter.arn,
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# S3 MANAGE DEPLOYMENT SEEDS AND ARTIFACT BUCKETS
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "manage_s3_pipeline_src_and_artifacts" {
    name = "s3-manage-pipeline-src-artifacts-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.manage_s3_pipeline_src_and_artifacts.json
  }

  data "aws_iam_policy_document" "manage_s3_pipeline_src_and_artifacts" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "s3:ListBucket",
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:PutBucketWebsite",
        "s3:GetBucketWebsite",
        "s3:DeleteBucketWebsite",
        "s3:GetBucketPolicy",
        "s3:PutBucketPolicy",
        "s3:PutBucketTagging",
        "s3:PutBucketCORS",
        "s3:GetBucketAcl",
        "s3:PutBucketAcl",
        "s3:GetObjectAcl",
        "s3:PutObjectAcl",
      ]
      resources = [
        local.s3_artifact_bucket_arn_pattern
      ]
    }

    statement {
      sid = "2"

      effect = "Allow"

      actions = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListObjects",
      ]
      resources = [
        "${local.s3_artifact_bucket_arn_pattern}/*"
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# CODEPIPELINE CREATE/READ/DELETE PIPELINE
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "codepipeline_create_delete_pipeline" {
    name = "codepipeline-create-delete-pipeline-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.codepipeline_create_delete_pipeline.json
  }

  data "aws_iam_policy_document" "codepipeline_create_delete_pipeline" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "codepipeline:CreatePipeline",
        "codepipeline:DeletePipeline",
        "codepipeline:ListActionExecutions"
      ]
      resources = ["*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# CODEPIPELINE PUT JOB RESULT
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "codepipeline_put_job_result" {
    name = "codepipeline-put-job-result-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.codepipeline_put_job_result.json
  }

  data "aws_iam_policy_document" "codepipeline_put_job_result" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "codepipeline:PutJobSuccessResult",
        "codepipeline:PutJobFailureResult",
      ]
      resources = ["*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# IAM PASS ROLE TO CODEPIPELINE
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "iam_pass_role_to_codepipeline" {
    name = "iam-pass-role-codepipeline-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.iam_pass_role_to_codepipeline.json
  }

  data "aws_iam_policy_document" "iam_pass_role_to_codepipeline" {
    version = "2012-10-17"

    statement {
      sid = "1"

      effect = "Allow"

      actions = [
        "iam:PassRole",
      ]
      resources = [aws_iam_role.ipfs_ens_codepipeline_iam.arn]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# POLICY FOR CODEPIPELINE
# ---------------------------------------------------------------------------------------------------------------------
  // TODO fix this policy
  resource "aws_iam_policy" "codepipeline_policy" {
    name = "ipfs-ens-codepipeline-policy-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.codepipeline_policy.json
  }

  data "aws_iam_policy_document" "codepipeline_policy" {
    version = "2012-10-17"

    statement {
      sid = "S3Access"

      effect = "Allow"

      actions = [
        "s3:*",
      ]

      resources = [
        local.s3_artifact_bucket_arn_pattern,
        "${local.s3_artifact_bucket_arn_pattern}/*"
      ]
    }

    statement {
      sid = "CodeBuildStart"

      effect = "Allow"

      actions = [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
      ]

      resources = ["*"]
    }

    statement {
      sid = "LambdaInvoke"

      effect = "Allow"

      actions = [
        "lambda:InvokeFunction",
      ]

      // A known issue with the Lambda IAM permissions system makes it impossible
      // to grant more granular permissions.  lambda:InvokeFunction cannot be called
      // on specific functions, and lambda:Invoke is not recognized as a valid policy.
      // Given that only our Lambda can create the CodePipeline which has this role,
      // I think it ought to be fine.  Frustrating, though.  - John
      //
      // https://stackoverflow.com/q/48031334/2128308
      resources = ["*"]
    }

    statement {
      sid = "ReadOnlyECR"

      effect = "Allow"

      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
      ]

      resources = ["*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# S3 FULL ACCESS MANAGED BUCKETS
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "s3_full_access_managed_buckets" {
    name = "s3-full-access-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.s3_full_access_managed_buckets.json
  }

  data "aws_iam_policy_document" "s3_full_access_managed_buckets" {
    version = "2012-10-17"

    statement {
      sid = "S3Access"

      effect = "Allow"

      actions = [
        "s3:*",
      ]

      resources = [
        local.s3_artifact_bucket_arn_pattern,
        "${local.s3_artifact_bucket_arn_pattern}/*"
      ]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# CODEBUILD BUILD START
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "codebuild_build_part" {
    name = "codebuild-build-part-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.codebuild_build_part.json
  }

  data "aws_iam_policy_document" "codebuild_build_part" {
    version = "2012-10-17"

    statement {
      sid = "CodeBuildStart"

      effect = "Allow"

      actions = [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild",
      ]

      resources = ["*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# LAMBDA INVOKE
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "lambda_invoke" {
    name = "lambda-invoke-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.lambda_invoke.json
  }

  data "aws_iam_policy_document" "lambda_invoke" {
    version = "2012-10-17"

    statement {
      sid = "LambdaInvoke"

      effect = "Allow"

      actions = [
        "lambda:InvokeFunction",
      ]

      // A known issue with the Lambda IAM permissions system makes it impossible
      // to grant more granular permissions.  lambda:InvokeFunction cannot be called
      // on specific functions, and lambda:Invoke is not recognized as a valid policy.
      // Given that only our Lambda can create the CodePipeline which has this role,
      // I think it ought to be fine.  Frustrating, though.  - John
      //
      // https://stackoverflow.com/q/48031334/2128308
      resources = ["*"]
    }
  }

# ---------------------------------------------------------------------------------------------------------------------
# ECR READ ONLY
# ---------------------------------------------------------------------------------------------------------------------
  resource "aws_iam_policy" "ecr_read_only" {
    name = "ecr-read-only-${local.sanitized_subdomain}"

    policy = data.aws_iam_policy_document.ecr_read_only.json
  }

  data "aws_iam_policy_document" "ecr_read_only" {
    version = "2012-10-17"

    statement {
      sid = "ReadOnlyECR"

      effect = "Allow"

      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
      ]

      resources = ["*"]
    }
  }