resource "random_password" "password" {
  length           = 30
  special          = false
  override_special = "_%@"
}


resource "aws_ssm_parameter" "wordpress" {
  name  = "/devops/us-east-2/passwords/wordpress-cluster"
  type  = "SecureString"
  value = random_password.password.result
}



resource "aws_rds_cluster" "default" {
	cluster_identifier = "dbname"
	engine = "aurora"
	engine_version = "5.6.10a"
	database_name = "dbname"
	master_username = "wordpress"
	master_password = random_password.password.result
	db_subnet_group_name = aws_db_subnet_group.default.name
	skip_final_snapshot = true  
	vpc_security_group_ids = [
		aws_security_group.wordpress-db.id
	]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
	count = 1
	identifier = "aurora-cluster-demo-${count.index +1}"
	cluster_identifier = aws_rds_cluster.default.cluster_identifier
	instance_class = "db.r4.large"
	engine_version = "5.6.10a"
	engine = "aurora"
}


resource "aws_rds_cluster_instance" "cluster_instances-reader" {
	count = 4
	identifier = "aurora-cluster-demo-reader-${count.index +1}"
	cluster_identifier = aws_rds_cluster.default.cluster_identifier
	instance_class = "db.r4.large"
	engine_version = "5.6.10a"
	engine = "aurora"
}


resource "aws_rds_cluster_instance" "cluster_instances-reader2" {
	count = 1
	identifier = "aurora-cluster-demo-reader-${count.index +2}"
	cluster_identifier = aws_rds_cluster.default.cluster_identifier
	instance_class = "db.r4.large"
	engine_version = "5.6.10a"
	engine = "aurora"
}

output "reader_endpoint" {
    value = aws_rds_cluster.default.reader_endpoint
}

output "writer_endpoint" {
    value = aws_rds_cluster.default.endpoint
}