#!/usr/bin/env bash
SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

SRC_PATH=${SCRIPT_DIR}/connectors
rm -rf ${SRC_PATH} && mkdir ${SRC_PATH}

## MSK Data Generator Souce Connector
echo "downloading msk data generator..."
DOWNLOAD_URL=https://github.com/awslabs/amazon-msk-data-generator/releases/download/v0.4.0/msk-data-generator-0.4-jar-with-dependencies.jar

curl -L -o ${SRC_PATH}/msk-data-generator.jar ${DOWNLOAD_URL}

## Download camel dynamodb sink connector
echo "download camel dynamodb sink connector..."
DOWNLOAD_URL=https://repo.maven.apache.org/maven2/org/apache/camel/kafkaconnector/camel-aws-ddb-sink-kafka-connector/3.18.2/camel-aws-ddb-sink-kafka-connector-3.18.2-package.tar.gz

# zip contents to create custom plugin of msk connect later
curl -o ${SRC_PATH}/camel-aws-ddb-sink-kafka-connector.tar.gz ${DOWNLOAD_URL} \
  && tar -xvzf ${SRC_PATH}/camel-aws-ddb-sink-kafka-connector.tar.gz -C ${SRC_PATH} \
  && cd ${SRC_PATH}/camel-aws-ddb-sink-kafka-connector \
  && zip -r camel-aws-ddb-sink-kafka-connector.zip . \
  && mv camel-aws-ddb-sink-kafka-connector.zip ${SRC_PATH} \
  && rm ${SRC_PATH}/camel-aws-ddb-sink-kafka-connector.tar.gz
