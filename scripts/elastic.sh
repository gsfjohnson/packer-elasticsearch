#!/usr/bin/env bash

set -e

# not used anymore.. will be upgrading to 2.1 asap
elasticsearch_version=$ELASTIC_VERSION

echo "Import Elasticsearch Key..."
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

echo "Create repo definition..."
cat <<EOF >/etc/yum.repos.d/elasticsearch.repo
[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=https://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
EOF

echo "Installing elasticsearch..."
yum -y install elasticsearch expect

echo "Start elasticsearh on boot..."
chkconfig elasticsearch on

echo "Install cloud-aws plugin..."
/usr/share/elasticsearch/bin/plugin install cloud-aws -b

echo "elasticsearch config"
sudo mkdir -p /etc/elasticsearch/configurable
mv /tmp/config/* /etc/elasticsearch/configurable

