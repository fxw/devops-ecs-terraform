locals {
  ecr_repository_tags = {
    Name        = "${var.environment}/fsmcore"
    Function    = "REPOSITORY"
    Description = "ECR FOR FSMCORE ${upper(var.environment)}"
  }
}

resource "aws_ecr_repository" "fsmcore-repository" {
  name = "${var.environment}/fsmcore"
  tags = merge(var.default_tags, local.ecr_repository_tags)

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "remove_policy" {
  repository = aws_ecr_repository.fsmcore-repository.name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images more than 10",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
