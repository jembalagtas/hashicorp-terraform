
/*output "ip" {
  value = ["${aws_instance.terraform-instance.*.public_ip}"]
}
*/
output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = ["${aws_instance.terraform-instance.*.public_dns}"]
}