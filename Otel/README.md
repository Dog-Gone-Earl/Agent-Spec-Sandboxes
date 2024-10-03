
Command being ran automatically
```
otelcol-contrib --config /etc/otelcol-contrib/collector.yaml
```

Checking out the otel prometheus endpoint metrics
```
curl http://0.0.0.0:8888/metrics
```

Helpful commands
```
sudo journalctl -u otelcol-contrib
```