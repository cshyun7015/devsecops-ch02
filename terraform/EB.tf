resource "aws_elastic_beanstalk_application" "Elastic_Beanstalk_Application" {
  name        = "ib07441-invoicer"
  description = "ib07441-invoicer-Securing DevOps Invoicer application"
}

resource "aws_elastic_beanstalk_environment" "Elastic_Beanstalk_Environment" {
  name                = "ib07441-invoicer-environment"
  description         = "ib07441-invoicer-environment"
  application         = aws_elastic_beanstalk_application.Elastic_Beanstalk_Application.name
  solution_stack_name = "64bit Amazon Linux 2017.03 v2.7.3 running Docker 17.03.1-ce"
  tier                = "WebServer"

  setting {
    namespace   = "aws:elasticbeanstalk:application:environment"
    name        = "INVOICER_USE_POSTGRES" 
    value       = "yes"
  }
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_USER" 
    value       = "admin"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_PASSWORD" 
    value       = "password"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_DB"
    value       = "ib07441-invoicer"
  } 
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_HOST"
    value       = aws_db_instance.DB_Instance.address
  }
  setting {
    namespace   = "aws:elasticbeanstalk:application:environment" 
    name        = "INVOICER_POSTGRES_SSLMODE"
    value       = "disable"
  }
}

resource "aws_elastic_beanstalk_application_version" "Elastic_Beanstalk_Application_Version" {
  name        = "ib07441-invoicer"
  application = aws_elastic_beanstalk_application.Elastic_Beanstalk_Application.name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.S3Bucket.id
  key         = aws_s3_bucket_object.S3_Bucket_Object.id
}