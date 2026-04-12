/* variable "user" {}
output "user" {
    value = var.user
} */

variable "user" {
    default = "sumit"
  
}

output "name" {
    value = var.user
}