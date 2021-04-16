variable "owner_name" {
    description = "리소스의 owner가 누구인지 설정"
    type        = string
    default     = "IB07441"
}
variable "project_name" {
    description = "Project Name"
    type        = string
    default     = "DevSecOps-ch02"
}
# variable "datetag" {
#     description = "datetag"
#     type        = string
#     default     = formatdate("YYYYMMDDhhmm", timestamp)
# }
# output "datetag" {
#     value = var.datetag
# }