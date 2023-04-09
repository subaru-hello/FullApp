/* Route53 */
resource "aws_route53_zone" "gakud" {
  name         = "${var.domain}"
}

resource "aws_route53_record" "main" {
  type    = "A"
  name    = "${var.domain}"
  zone_id = "${aws_route53_zone.gakud.id}"

  alias {
    name                   = "${aws_lb.nestjs_alb.dns_name}"
    zone_id                = "${aws_lb.nestjs_alb.zone_id}"
    evaluate_target_health = true
  }
}

/* バックエンドのdomain */
resource "aws_route53_record" "nestjs_subdomain" {
  zone_id = aws_route53_zone.gakud.id
  name    = "api.gakud.de"
  type    = "A"

  alias {
    name                   = aws_lb.nestjs_alb.dns_name
    zone_id                = aws_lb.nestjs_alb.zone_id
    evaluate_target_health = false
  }
}