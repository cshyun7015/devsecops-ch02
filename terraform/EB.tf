resource "aws_elastic_beanstalk_application" "Elastic_Beanstalk_Application" {
  name        = "ib07441-invoicer"
  description = "ib07441-invoicer-Securing DevOps Invoicer application"
}

data "aws_elastic_beanstalk_solution_stack" "Elastic_Beanstalk_Solution_Stack" {
  most_recent = true

  name_regex = "^64bit Amazon Linux (.*) running Docker (.*)$"
}

resource "aws_elastic_beanstalk_environment" "Elastic_Beanstalk_Environment" {
  name                = "ib07441-invoicer-environment"
  description         = "ib07441-invoicer-environment"
  application         = aws_elastic_beanstalk_application.Elastic_Beanstalk_Application.name
  #solution_stack_name = "64bit Amazon Linux 2018.03 v2.16.6 running Docker 19.03.13-ce"
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.Elastic_Beanstalk_Solution_Stack.name
  tier                = "WebServer"

  setting {
    namespace   = "aws:elasticbeanstalk:application:environment"
    name        = "INVOICER_USE_POSTGRES" 
    value       = "yes"
  }
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_USER" 
    value       = "ib07441"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_PASSWORD" 
    value       = "password"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_DB"
    value       = "ib07441invoicer"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_HOST"
    value       = aws_db_instance.DB_Instance.endpoint
  }
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_SSLMODE"
    value       = "disable"
  }
  setting {
    namespace   = "aws:autoscaling:launchconfiguration" 
    name        = "IamInstanceProfile"
    value       = "aws-elasticbeanstalk-ec2-role"
  }
  # ..........................................................................
  # required settings
  #setting {
  #  namespace = "aws:ec2:vpc"
  #  name      = "VPCId"
  #  value     = aws_vpc.VPC.id
  #}
  #setting {
  #  namespace = "aws:ec2:vpc"
  #  name      = "Subnets"
  #  value     = "aws_subnet.publicSubnet01.id,aws_subnet.publicSubnet02.id,aws_subnet.publicSubnet03.id"
  #}
}

resource "aws_elastic_beanstalk_application_version" "Elastic_Beanstalk_Application_Version" {
  name        = "ib07441-invoicer"
  application = aws_elastic_beanstalk_application.Elastic_Beanstalk_Application.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.S3Bucket.id
  key         = aws_s3_bucket_object.S3_Bucket_Object.id
}

output "Elastic_Beanstalk_Application" {
  value = aws_elastic_beanstalk_application.Elastic_Beanstalk_Application.name
}

output "Elastic_Beanstalk_Environment" {
  value = aws_elastic_beanstalk_environment.Elastic_Beanstalk_Environment.id
}