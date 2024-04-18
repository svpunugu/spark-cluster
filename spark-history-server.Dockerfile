FROM spark-base

# -- Runtime

ARG spark_history_server_ui=18080

EXPOSE ${sspark_history_server_ui}
CMD bin/spark-class org.apache.spark.deploy.history.HistoryServer >> logs/spark-history.out