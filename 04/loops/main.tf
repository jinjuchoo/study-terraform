provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_iam_user" "for_each_set" {
    for_each = toset([
        "for-each-set-user-1",
        "for-each-set-user-2",
        "for-each-set-user-3",
    ])

    name = each.key
}

output "for_each_set_user_arns" {
    value = values(aws_iam_user.for_each_set).*.arn
}
