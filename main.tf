provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_elastic_beanstalk_application" "django_app" {
  name        = "DjangoApp"  # Replace with your application name
  description = "Django Application"
}

resource "aws_elastic_beanstalk_environment" "django_env" {
  name        = "DjangoEnv"  # Replace with your environment name
  application = aws_elastic_beanstalk_application.django_app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.4.0 running Python 3.8"  # Choose the appropriate Python version
  instance_type = "t2.micro"  # Choose the instance type
  key_name = "your-key-pair"  # Replace with your key pair name

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"  # Replace with an appropriate IAM instance profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:container:python"
    name      = "WSGIPath"
    value     = "your_project_name.wsgi:application"  # Replace with your Django project's WSGI path
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DJANGO_SETTINGS_MODULE"
    value     = "your_project_name.settings"  # Replace with your Django project's settings module
  }
}
