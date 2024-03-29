output "readiness_probes" {
  value = [
    {
      initial_delay_seconds            = var.initial_delay
      period_seconds                   = var.period
      timeout_seconds                  = var.timeout
      success_threshold                = var.success_threshold
      failure_threshold                = var.failure_threshold
      termination_grace_period_seconds = var.termination_grace_period

      http_get = jsonencode({
        scheme       = var.http_scheme
        path         = var.http_path
        port         = var.http_port
        http_headers = var.http_headers
      })
    }
  ]
}
