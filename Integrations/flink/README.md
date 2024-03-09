# Openmetrics (Host)

## 1. Spin Up Sandbox:
```
./run.sh up;
./run.sh ssh
```

## 2. Configure Datadog instructions for flink

<link>https://docs.datadoghq.com/integrations/flink/#setup</link>

## 3. RUN FLINK APP
``` 
cd flink-1.18.1/
 ./bin/start-cluster.sh
 ./bin/flink run examples/streaming/WordCount.jar
```
