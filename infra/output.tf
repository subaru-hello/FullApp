output "alb_url" {
  value = aws_lb.nestjs_alb.dns_name
  description = "The DNS name of the Application Load Balancer (ALB)"
}

output "cloudfront_url" {
  value       = aws_cloudfront_distribution.nextjs_distribution.domain_name
  description = "The CloudFront distribution domain name (URL)"
}