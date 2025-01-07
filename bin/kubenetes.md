``sh
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

kubeadm join cluster-endpoint:6443 --token m9xej2.j5umbxacicraegff \
--discovery-token-ca-cert-hash sha256:8de4ba37f8f66cc1c551d94ea556bb4aff5ac751a4764e6e89ba39b405f6ca21 \
--control-plane

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join cluster-endpoint:6443 --token m9xej2.j5umbxacicraegff \
--discovery-token-ca-cert-hash sha256:8de4ba37f8f66cc1c551d94ea556bb4aff5ac751a4764e6e89ba39b405f6ca21 