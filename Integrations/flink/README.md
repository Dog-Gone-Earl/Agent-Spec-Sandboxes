# Flink Integration

## 1. Spin Up Sandbox:
```
./run.sh up;
./run.sh ssh
```

## 2. Follow Datadog instructions for flink configuration

<link>https://docs.datadoghq.com/integrations/flink/#setup</link>

## 3. RUN FLINK APP
``` 
cd flink-1.18.1/
 ./bin/start-cluster.sh
 ./bin/flink run examples/streaming/WordCount.jar
```
