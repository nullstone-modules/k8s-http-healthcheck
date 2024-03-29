# HTTP Healthcheck

Adds an HTTP healthcheck to a Kubernetes app using a readiness probe.

## Details on HTTP probe

For an HTTP probe, the kubelet sends an HTTP request to the specified port and path to perform the check. 
The kubelet sends the probe to the Pod's IP address, unless the address is overridden by the optional host field in httpGet. 
If scheme field is set to HTTPS, the kubelet sends an HTTPS request skipping the certificate verification. 
In most scenarios, you do not want to set the host field. Here's one scenario where you would set it. 
Suppose the container listens on 127.0.0.1 and the Pod's hostNetwork field is true. 
Then host, under httpGet, should be set to 127.0.0.1. 
If your pod relies on virtual hosts, which is probably the more common case, you should not use host, but rather set the Host header in httpHeaders.
