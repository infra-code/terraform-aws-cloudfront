#--------------------------------------------------------------
# AWS Variables
#--------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}


#--------------------------------------------------------------
# Application Variables
#--------------------------------------------------------------
variable "service_name" {
  type = string
}


#--------------------------------------------------------------
# Cloudfront Variables
#--------------------------------------------------------------
variable "cloudfront_custom_error_response_error_codes" {
  type        = string
  description = "CSV list of HTTP status codes that you want to customize."
  default     = "400,403,404,500"
}

variable "cloudfront_custom_error_response_error_caching_min_ttl" {
  type        = number
  description = "The minimum amount of time you want HTTP error codes to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  default     = 300
}

variable "cloudfront_custom_error_response_response_code" {
  type        = number
  description = "The HTTP status code that you want CloudFront to return with the custom error page to the viewer."
  default     = 200
}

variable "cloudfront_custom_error_response_response_page_path" {
  type        = string
  description = "The path of the custom error page, defaults to '/{cloudfront_default_root_object}'"
  default     = ""
}

variable "cloudfront_default_cache_behavior_allowed_methods" {
  type        = string
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = "GET,HEAD,OPTIONS"
}

variable "cloudfront_default_cache_behavior_cached_methods" {
  type        = string
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = "GET,HEAD"
}

variable "cloudfront_default_cache_behavior_compress" {
  type        = bool
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header"
  default     = true
}

variable "cloudfront_default_cache_behavior_default_ttl" {
  type        = number
  description = "The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header."
  default     = 86400
}

variable "cloudfront_default_cache_behavior_max_ttl" {
  type        = number
  description = "The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers."
  default     = 31536000
}

variable "cloudfront_default_cache_behavior_min_ttl" {
  type        = number
  description = "The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated."
  default     = 0
}

variable "cloudfront_default_cache_behavior_viewer_protocol_policy" {
  type        = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https"
  default     = "redirect-to-https"
}

variable "cloudfront_default_root_object" {
  type        = string
  description = "The object that you want CloudFront to return"
  default     = "index.html"
}

variable "cloudfront_is_ipv6_enabled" {
  type        = bool
  description = "Whether the IPv6 is enabled for the distribution"
  default     = false
}

variable "cloudfront_origin_bucket_domain_name" {
  type        = string
  description = "Domain name for the Origin bucket"
}

variable "cloudfront_price_class" {
  type        = string
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = "PriceClass_200"
}

variable "cloudfront_restrictions_enabled" {
  type        = bool
  description = "Whether the distribution is restricting access to your content based on the geographic location of your viewers."
  default     = true
}

variable "cloudfront_restrictions_geo_restriction_locations" {
  type        = string
  description = "The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)"
  default     = "US,CA"
}

variable "cloudfront_restrictions_geo_restriction_restriction_type" {
  type        = string
  description = "The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist"
  default     = "none"
}

variable "cloudfront_viewer_certificate_acm_certificate_arn" {
  type        = string
  description = "The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution."
  default     = "cloudfront_default_certificate"
}

variable "cloudfront_viewer_certificate_minimum_protocol_version" {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.2_2018"
}

variable "cloudfront_viewer_certificate_ssl_support_method" {
  type        = string
  description = "Specifies how you want CloudFront to serve HTTPS requests"
  default     = "sni-only"
}

#--------------------------------------------------------------
# Route53 Variables
#--------------------------------------------------------------
variable "route53_zone_id" {
  type = string
}

variable "route53_domain_name" {
  type = string
}

variable "route53_root_domain" {
  type = bool

  default = false
}