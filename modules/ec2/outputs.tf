/* output "alb_dns_name" {
  value = aws_lb.ALB-FSMCORE.dns_name
} */

output "sg_SG-I-EC2-FSMCORE" {
 value = "${aws_security_group.SG-I-EC2-FSMCORE.id}"
}