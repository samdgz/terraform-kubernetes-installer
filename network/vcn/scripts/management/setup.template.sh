#!/bin/bash -x

EXTERNAL_IP=$(curl -s -m 10 http://whatismyip.akamai.com/)
NAMESPACE=$(echo -n "${domain_name}" | sed "s/\.oraclevcn\.com//g")
FQDN_HOSTNAME=$(getent hosts $(ip route get 1 | awk '{print $NF;exit}') | awk '{print $2}')

# Pull instance metadata
curl -sL --retry 3 http://169.254.169.254/opc/v1/instance/ | tee /tmp/instance_meta.json

ETCD_ENDPOINTS=${etcd_endpoints}
export HOSTNAME=$(hostname)

export IP_LOCAL=$(ip route show to 0.0.0.0/0 | awk '{ print $5 }' | xargs ip addr show | grep -Po 'inet \K[\d.]+')

SUBNET=$(getent hosts $IP_LOCAL | awk '{print $2}' | cut -d. -f2)

## Flannel
######################################
curl -L --retry 3 https://github.com/coreos/flannel/releases/download/${flannel_ver}/flanneld-amd64 -o /usr/local/bin/flanneld \
  && chmod 755 /usr/local/bin/flanneld
export ETCD_SERVER=${etcd_endpoints}
echo "IP_LOCAL: $IP_LOCAL ETCD_SERVER: $ETCD_SERVER"
envsubst </root/services/flannel.service >/etc/systemd/system/flannel.service
systemctl daemon-reload && systemctl enable flannel && systemctl start flannel

# Create cni bridge interface w/ IP from flannel
cp /root/services/cni-bridge.service /etc/systemd/system/cni-bridge.service
cp /root/services/cni-bridge.sh /usr/local/bin/cni-bridge.sh && chmod +x /usr/local/bin/cni-bridge.sh
systemctl enable cni-bridge && systemctl start cni-bridge

## Docker
######################################
until yum -y install docker-engine-${docker_ver}; do sleep 1 && echo -n "."; done

cat <<EOF > /etc/sysconfig/docker-network
DOCKER_NETWORK_OPTIONS="--bridge=cni0 --iptables=false --ip-masq=false"
EOF

cat <<EOF > /etc/sysconfig/docker
OPTIONS="--selinux-enabled --log-opt max-size=${docker_max_log_size} --log-opt max-file=${docker_max_log_files} --metrics-addr 0.0.0.0:9323 --experimental"
DOCKER_CERT_PATH=/etc/docker
GOTRACEBACK=crash
EOF

systemctl daemon-reload
systemctl enable docker
systemctl start docker

# Disable SELinux and firewall
sudo sed -i  s/SELINUX=enforcing/SELINUX=permissive/ /etc/selinux/config
setenforce 0
systemctl stop firewalld.service
systemctl disable firewalld.service

${reverse_proxy_setup}

echo "Finished running setup.sh"
