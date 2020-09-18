# Kubernetes Network Test

This repo contains a way to test connectivity between all of the nodes in a Kubernetes cluster.

A network test is performed by deploying an application to every node and then uses that application to test connectivity to every other node.

For example, if you have 3 nodes, your test will look like this...

```
=> Start network test
node1 can reach node1
node1 can reach node2
node1 can reach node3
node2 can reach node1
node2 can reach node2
node2 can reach node3
node3 can reach node1
node3 can reach node2
node3 can reach node3
=> End network test
```

## KubernetesNetworkTest.Web

This application is very basic .Net Core website. Ping does not work with Windows containers so the only way to test and verify connectivity is with an http request.

## KubernetesNetworkTest.Console

This application is a very basic .Net Core console app that takes in a single argument and attempts a GET request.

## Docker Images

I used the `Dockerfile` to build 2 Docker images, one for Windows using the 1809 kernel and another for linux.

You can use the `Dockerfile` to build your own images and you should not have to change anything to get cross platform support.

Windows Image: `brianharwell/kubernetesnetworktest:1809`
Linux Image: `brianharwell/kubernetesnetworktest:linux`

## Usage

Deploy the `daemonset.yml` file against your Kubernetes cluster. This will deploy 2 daemonsets, one for Linux and another for Windows.

> Note: My cluster was created with Rancher so you may need to modify the tolerations for your cluster.

1. `kubectl apply -f .\daemonset.yml`
2. `.\network-test.ps1`
