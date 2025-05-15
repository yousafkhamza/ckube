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

## With ckube Tool

Get pods with name only (default):

```bash
ckube pods
```

Get pods with name and status:

```bash
ckube pods name,status
```

Get pods with name, status, IP and node:

```bash
ckube pods name,status,ip,node
```

Get pods with restart count and image:

```bash
ckube pods name,restarts,image
```

Get pods in specific namespace:

```bash
ckube pods name,status -n kube-system
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
