FROM cluster-base

# -- Layer: Apache Spark
ARG spark_version=3.5.1
ARG hadoop_version=3

RUN apt-get update -y && \
    apt-get install -y curl rsync procps && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/ && \
    mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs && \
    mkdir ${shared_workspace}/spark-events && \
    rm spark.tgz

ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV SPARK_DRIVER_HOST 192.168.1.211
ENV SPARK_UI_BIND_ADDRESS 0.0.0.0
ENV SPARK_PUBLIC_DNS=192.168.1.211

# Copy custom spark-defaults.conf file with UI configuration
COPY spark-defaults.conf /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/conf/spark-defaults.conf

# -- Runtime
WORKDIR ${SPARK_HOME}