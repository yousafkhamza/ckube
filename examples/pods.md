# Pod Examples

## Traditional kubectl Commands

Get pods with name and status:

```bash
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase
```

Get pods with name, status, IP and node:

```bash
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,IP:.status.podIP,NODE:.spec.nodeName
```

Get pods with restart count and image:

```bash
kubectl get pods -o=custom-columns=NAME:.metadata.name,RESTARTS:.status.containerStatuses[0].restartCount,IMAGE:.spec.containers[0].image
```

## With kubectl-columns Tool

Get pods with name only (default):

```bash
kubectl-columns pods
```

Get pods with name and status:

```bash
kubectl-columns pods name,status
```

Get pods with name, status, IP and node:

```bash
kubectl-columns pods name,status,ip,node
```

Get pods with restart count and image:

```bash
kubectl-columns pods name,restarts,image
```

Get pods in specific namespace:

```bash
kubectl-columns pods name,status -n kube-system
```

## Available Columns for Pods

- `name`: Pod name (.metadata.name)
- `status`: Current phase (.status.phase)
- `node`: Node where pod is running (.spec.nodeName)
- `ip`: Pod IP address (.status.podIP)
- `namespace`: Pod namespace (.metadata.namespace)
- `age`: Creation timestamp (.metadata.creationTimestamp)
- `ready`: Ready condition status (.status.conditions[?(@.type=="Ready")].status)
- `restarts`: Container restart count (.status.containerStatuses[0].restartCount)
- `image`: Container image (.spec.containers[0].image)
