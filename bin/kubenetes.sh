#!/usr/bin

# 关闭防火墙
systemctl stop firewalld
systemctl disable firewalld

# 关闭selinux
sed -i 's/enforcing/disabled/' /etc/selinux/config
setenforce 0

# 关闭swap
swapoff -a
sed -ri 's/.*swap.*/#&/' /etc/fstab

# 设置主机名
hostnamectl set-hostname "$1"

cat >> /etc/hosts << EOF
  192.168.56.100 k8s-mater1
  192.168.56.110 k8s-node1
  192.168.56.111 k8s-node1
EOF

# 将桥接IPv4流量传递到iptables的链

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables =1
EOF

cat /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

systemctl --system

# 时间同步
yum install ntpdate -y
ntpdate time windows.com

# 添加阿里云yum软件源
cat > /etc/yum.repos.d/kubernetes.repo << EOF
[kubernetes]
name=kubernetes
baseUrl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
https://mirros.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet-1.18.0 kubeadm-1.18.0 kubectl-1.18.0

kubeadm init \
--apiserver-advertise-address=192.168.56.100 \
--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version v1.18.0 \
--service-cidr=10.96.0.0/12 \
--pod-network-cidr=10.244.0.0/16

kubeadm init \
--apiserver-advertise-address=192.168.1.10 \
--control-plane-endpoint=cluster-endpoint \
--image-repository registry.cn-hangzhou.aliyuncs.com/lfy_k8s_images \
--kubernetes-version v1.20.9 \
--service-cidr=10.96.0.0/16 \
--pod-network-cidr=192.168.0.0/16


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm join 192.168.56.100:6443 --token qk5c3y.zb30e1czpxykn9qw \
    --discovery-token-ca-cert-hash sha256:26822a0f7ad727ef983f7946e4729a1d32428890fc8bdde321c1620e97b90dc1
