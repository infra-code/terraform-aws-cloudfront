locals {
  # Defaults
  cloudfront_default_custom_error_response_response_page_path = "/${var.cloudfront_default_root_object}"
  cloudfront_default_path                                     = "/${var.service_name}"
}  