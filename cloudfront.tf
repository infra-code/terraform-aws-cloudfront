resource "aws_cloudfront_distribution" "main" {
  price_class = var.cloudfront_price_class

  aliases             = var.route53_root_domain == true ? [var.route53_domain_name, data.aws_route53_zone.main.name] : [var.route53_domain_name]
  is_ipv6_enabled     = var.cloudfront_is_ipv6_enabled
  comment             = var.service_name
  default_root_object = var.cloudfront_default_root_object
  enabled             = true
  wait_for_deployment = false

  default_cache_behavior {
    allowed_methods        = split(",", var.cloudfront_default_cache_behavior_allowed_methods)
    cached_methods         = split(",", var.cloudfront_default_cache_behavior_cached_methods)
    target_origin_id       = "S3-${var.service_name}-us-east-1"
    viewer_protocol_policy = var.cloudfront_default_cache_behavior_viewer_protocol_policy
    compress               = var.cloudfront_default_cache_behavior_compress

    default_ttl = var.cloudfront_default_cache_behavior_default_ttl
    min_ttl     = var.cloudfront_default_cache_behavior_min_ttl
    max_ttl     = var.cloudfront_default_cache_behavior_max_ttl

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # Origin
  origin {
    domain_name = var.cloudfront_origin_bucket_domain_name
    origin_id   = "S3-${var.service_name}-us-east-1"
    origin_path = "/${var.service_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  dynamic "restrictions" {
    for_each = var.cloudfront_restrictions_enabled == true && length(var.cloudfront_restrictions_geo_restriction_locations) > 0 ? [1] : []

    content {
      geo_restriction {
        restriction_type = var.cloudfront_restrictions_geo_restriction_restriction_type
        locations        = split(",", var.cloudfront_restrictions_geo_restriction_locations)
      }
    }
  }


  dynamic "custom_error_response" {
    for_each = split(",", var.cloudfront_custom_error_response_error_codes)

    content {
      error_code            = custom_error_response.value
      error_caching_min_ttl = var.cloudfront_custom_error_response_error_caching_min_ttl
      response_code         = var.cloudfront_custom_error_response_response_code
      response_page_path    = var.cloudfront_custom_error_response_response_page_path != "" ? var.cloudfront_custom_error_response_response_page_path : local.cloudfront_default_custom_error_response_response_page_path
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.cloudfront_viewer_certificate_acm_certificate_arn
    minimum_protocol_version       = var.cloudfront_viewer_certificate_minimum_protocol_version
    ssl_support_method             = var.cloudfront_viewer_certificate_ssl_support_method
    cloudfront_default_certificate = var.cloudfront_viewer_certificate_acm_certificate_arn == "cloudfront_default_certificate"
  }

  lifecycle {
    ignore_changes = []
  }
}


resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Identity for => ${var.service_name}"
}