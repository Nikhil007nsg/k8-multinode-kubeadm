# 1. Install NVIDIA Device Plugin

kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/master/nvidia-device-plugin.yml

#Verify the plugin is running:

kubectl get pods -n kube-system | grep nvidia

# 2. Create a Docker Image for Whisper

FROM nvidia/cuda:11.0-base

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Install Whisper dependencies
RUN pip3 install whisper

# Copy your Whisper application code
COPY . /app
WORKDIR /app

# Run the application
CMD ["python3", "whisper_app.py"]


# docker build -t your-username/whisper:latest .
# docker push your-username/whisper:latest

## Q- how to upgrade kubeadm version without disturbing the current version setup.
step 1 - check version of kubeadm,kubectl,kubelet in control plane

          kubeadm version
          kubectl version
          kubelet version

step 2 - Now upgrade kubeadm to the desired version v 1.31.0

        sudo apt-get update
        sudo apt-get install -y kubeadm=1.31.0
        sudo kubeadm version

step 3 - After upgrading the kubeadm binary, you can check what will happen during the upgrade by running a dry-run

        sudo kubeadm upgrade plan

step 4 - After confirming the version and plan, upgrade the Kubernetes control plane components on the master node:

        sudo kubeadm upgrade apply v1.31.0

step 5 -  After upgrading kubeadm, you need to upgrade kubelet and kubectl on the control plane node:

        sudo apt-get install -y kubelet=1.31.0 kubectl=1.31.0
        sudo systemctl daemon-reload
        sudo systemctl restart kubelet

step 6 - After the upgrade is successful and the control plane is functional, you can uncordon the node to allow scheduling:

        kubectl uncordon <control-plane-node>

step 7 - Follow same steps for all worker node.













