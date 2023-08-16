Generates a fully working environment with ECS.



## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0, < 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0, < 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_alb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appautoscaling_target.app_scale_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.app_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecsTaskExecutionRole](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs-ssm-role-policy-attach-app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs-ssm-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs-ssm-role-policy-attachment-task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecsTaskExecutionRole_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.route53-record-NLB2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.lb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.lb_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_security_group.nsg_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nsg_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress_lb_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nsg_lb_egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nsg_task_egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nsg_task_ingress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nsg_task_ingress_rule2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nsg_task_ingress_rule3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_elb_service_account.elb_account_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_iam_policy.AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.allow_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.app_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_route53_zone.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accountId"></a> [accountId](#input\_accountId) | n/a | `string` | `"000312342342150"` | no |
| <a name="input_app"></a> [app](#input\_app) | The application's name | `string` | `"api"` | no |
| <a name="input_aws_s3_bucket_name"></a> [aws\_s3\_bucket\_name](#input\_aws\_s3\_bucket\_name) | The name of the bucket that will receive the log objects | `string` | `"api-dev-us-west-2"` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container to run | `string` | `"app"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port the container will listen on, used for load balancer health check Best practice is that this value is higher than 1024 so the container processes isn't running at root. | `string` | `"80"` | no |
| <a name="input_default_backend_image"></a> [default\_backend\_image](#input\_default\_backend\_image) | n/a | `string` | `"23525235252.dkr.ecr.us-west-2.amazonaws.com/api:0.1"` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused | `string` | `"30"` | no |
| <a name="input_ecs_autoscale_max_instances"></a> [ecs\_autoscale\_max\_instances](#input\_ecs\_autoscale\_max\_instances) | The maximum number of containers that should be running. used by both autoscale-perf.tf and autoscale.time.tf | `string` | `"8"` | no |
| <a name="input_ecs_autoscale_min_instances"></a> [ecs\_autoscale\_min\_instances](#input\_ecs\_autoscale\_min\_instances) | The minimum number of containers that should be running. Must be at least 1. used by both autoscale-perf.tf and autoscale.time.tf For production, consider using at least "2". | `string` | `"2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment that is being built | `string` | `"Development"` | no |
| <a name="input_environmentshort"></a> [environmentshort](#input\_environmentshort) | n/a | `string` | `"dev"` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | The path to the health check for the load balancer to know if the container(s) are ready | `string` | `"/swagger/index.html"` | no |
| <a name="input_health_check_interval"></a> [health\_check\_interval](#input\_health\_check\_interval) | How often to check the liveliness of the container | `string` | `"30"` | no |
| <a name="input_health_check_matcher"></a> [health\_check\_matcher](#input\_health\_check\_matcher) | What HTTP response code to listen for | `string` | `"200-499"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | n/a | `string` | `"80"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | n/a | `string` | `"HTTP"` | no |
| <a name="input_health_check_timeout"></a> [health\_check\_timeout](#input\_health\_check\_timeout) | How long to wait for the response on the health check path | `string` | `"5"` | no |
| <a name="input_healthcheck_port"></a> [healthcheck\_port](#input\_healthcheck\_port) | n/a | `string` | `"80"` | no |
| <a name="input_https_port"></a> [https\_port](#input\_https\_port) | The port to listen on for HTTPS (Default is 443) | `string` | `"443"` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether the application is available on the public internet, also will determine which subnets will be used (public or private) | `bool` | `false` | no |
| <a name="input_lb_access_logs_expiration_days"></a> [lb\_access\_logs\_expiration\_days](#input\_lb\_access\_logs\_expiration\_days) | n/a | `string` | `"10"` | no |
| <a name="input_lb_port"></a> [lb\_port](#input\_lb\_port) | The port the load balancer will listen on, then direct traffic to the applicable target group/s | `string` | `"443"` | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | The load balancer protocol | `string` | `"HTTPS"` | no |
| <a name="input_logs_retention_in_days"></a> [logs\_retention\_in\_days](#input\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events | `number` | `90` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region to use for the dev environment's infrastructure | `string` | `"us-west-2"` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | How many containers to run | `string` | `"2"` | no |
| <a name="input_route53-zone-id"></a> [route53-zone-id](#input\_route53-zone-id) | Zone id for domain | `string` | `"ZRDWDGJO8TRP47Q"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "Environment": "Development",<br>  "JIRA_TICKET": "XXXX"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | DEV VPC | `string` | `"vpc-03d12523525520"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Environment_TAG"></a> [Environment\_TAG](#output\_Environment\_TAG) | Tag for the env |
| <a name="output_Healthcheck_path"></a> [Healthcheck\_path](#output\_Healthcheck\_path) | Health Check Path |
| <a name="output_container_port"></a> [container\_port](#output\_container\_port) | container port |
| <a name="output_ecs_name"></a> [ecs\_name](#output\_ecs\_name) | ECS Cluster Name |
| <a name="output_image_name"></a> [image\_name](#output\_image\_name) | ECR Image Name |
| <a name="output_lb_port"></a> [lb\_port](#output\_lb\_port) | Load Balancer port |
| <a name="output_route53-record"></a> [route53-record](#output\_route53-record) | Private DNS Name |
| <a name="output_route53-record-NLB2"></a> [route53-record-NLB2](#output\_route53-record-NLB2) | DNS Name of the NLB |
| <a name="output_task-execution-role"></a> [task-execution-role](#output\_task-execution-role) | Task Execution Role: ECS task execution roles grant the ECS agents permission to make AWS API calls who are responsible for managing the tasks in the cluster. That means the task is able to send container logs to CloudWatch or pull a container image from Amazon ECR. |
| <a name="output_task-role"></a> [task-role](#output\_task-role) | Task Role: ECS task roles allow the containers in your task to assume an IAM role to call AWS APIs without having to use AWS Credentials inside the containers |
