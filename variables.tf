variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

variable "http_scheme" {
  type        = string
  default     = "HTTP"
  description = <<EOF
Scheme to use for connecting to the host (HTTP or HTTPS). Defaults to "HTTP".
EOF
}

variable "http_path" {
  type        = string
  default     = "/"
  description = <<EOF
Path to access on the HTTP server. Defaults to "/".
EOF
}

variable "http_port" {
  type        = number
  default     = null
  description = <<EOF
Name or number of the port to access on the container. Number must be in the range 1 to 65535. Defaults to app's `container_port`.
EOF
}

variable "http_headers" {
  type        = map(string)
  default     = null
  description = <<EOF
Custom headers to set in the request. HTTP allows repeated headers.
EOF
}

variable "initial_delay" {
  type        = number
  default     = 0
  description = <<EOF
Number of seconds after the container has started before startup, liveness or readiness probes are initiated. If a startup probe is defined, liveness and readiness probe delays do not begin until the startup probe has succeeded. If the value of periodSeconds is greater than initialDelaySeconds then the initialDelaySeconds would be ignored. Defaults to 0 seconds. Minimum value is 0.
EOF

  validation {
    condition     = var.initial_delay >= 0
    error_message = "cannot be less than 0"
  }
}

variable "period" {
  type        = number
  default     = 10
  description = <<EOF
How often (in seconds) to perform the probe. Default to 10 seconds. The minimum value is 1.
EOF

  validation {
    condition     = var.period >= 1
    error_message = "cannot be less than 1"
  }
}

variable "timeout" {
  type        = number
  default     = 1
  description = <<EOF
Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1.
EOF

  validation {
    condition     = var.timeout >= 1
    error_message = "cannot be less than 1"
  }
}

variable "success_threshold" {
  type        = number
  default     = 1
  description = <<EOF
Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup Probes. Minimum value is 1.
EOF

  validation {
    condition     = var.success_threshold >= 1
    error_message = "cannot be less than 1"
  }
}

variable "failure_threshold" {
  type        = number
  default     = 1
  description = <<EOF
After a probe fails failure_threshold times in a row, Kubernetes considers that the overall check has failed: the container is not ready/healthy/live. For the case of a startup or liveness probe, if at least failureThreshold probes have failed, Kubernetes treats the container as unhealthy and triggers a restart for that specific container. The kubelet honors the setting of terminationGracePeriodSeconds for that container. For a failed readiness probe, the kubelet continues running the container that failed checks, and also continues to run more probes; because the check failed, the kubelet sets the Ready [condition](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-conditions) on the Pod to false.
EOF
}

variable "termination_grace_period" {
  type        = number
  default     = 30
  description = <<EOF
Configure a grace period for the kubelet to wait between triggering a shut down of the failed container, and then forcing the container runtime to stop that container. The default is to inherit the Pod-level value for terminationGracePeriodSeconds (30 seconds if not specified), and the minimum value is 1. See probe-level [terminationGracePeriodSeconds](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#probe-level-terminationgraceperiodseconds) for more detail.
EOF

  validation {
    condition     = var.termination_grace_period >= 1
    error_message = "cannot be less than 1"
  }
}
