# The load balancer DNS name
output "route53-record-NLB2" {
  value       = aws_alb.main.dns_name
  description = "DNS Name of the NLB"
}
output "route53-record" {
  value       = aws_route53_record.route53-record-NLB2.name
  description = "Private DNS Name"
}
output "ecs_name" {
  value       = aws_ecs_cluster.app.name
  description = "ECS Cluster Name"
}
output "image_name" {
  value       = var.default_backend_image
  description = "ECR Image Name"
}
output "container_port" {
  value       = var.container_port
  description = "container port"
}
output "lb_port" {
  value       = var.lb_port
  description = "Load Balancer port"
}
output "Healthcheck_path" {
  value       = var.health_check
  description = "Health Check Path"
}
output "task-role" {
  value       = aws_iam_role.app_role.arn
  description = "Task Role: ECS task roles allow the containers in your task to assume an IAM role to call AWS APIs without having to use AWS Credentials inside the containers"
}
output "task-execution-role" {
  value       = aws_iam_role.ecsTaskExecutionRole.arn
  description = "Task Execution Role: ECS task execution roles grant the ECS agents permission to make AWS API calls who are responsible for managing the tasks in the cluster. That means the task is able to send container logs to CloudWatch or pull a container image from Amazon ECR."

}
output "Environment_TAG" {
  value       = var.tags.JIRA_TICKET
  description = "Tag for the env"
}
