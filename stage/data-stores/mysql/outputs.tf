output "address" {
  value       = aws_db_instance.jinju-rds.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = aws_db_instance.jinju-rds.port
  description = "The port the database is listening on"
}

output "vpcid" {
  value       = aws_vpc.jinju-vpc.id
  description = "jinju VPC Id"
}
