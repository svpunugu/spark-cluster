FROM spark-base

# -- Runtime

#RUN rsync -a /tmp/spark-events {slaves}:/tmp/spark-events

ARG spark_master_web_ui=8080

EXPOSE ${spark_master_web_ui} ${SPARK_MASTER_PORT}
CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out