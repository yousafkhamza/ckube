# Basic Usage Examples

## Traditional kubectl vs kubectl-columns

### Pods Example

**Traditional kubectl with custom-columns:**

```bash
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName,IP:.status.podIP
```

**With kubectl-columns:**

```bash
kubectl-columns pods name,status,node,ip
```

### Deployments Example

**Traditional kubectl with custom-columns:**

```bash
kubectl get deployments -o=custom-columns=NAME:.metadata.name,READY:.status.readyReplicas,AVAILABLE:.status.availableReplicas,AGE:.metadata.creationTimestamp
```

**With kubectl-columns:**

```bash
kubectl-columns deployments name,ready,available,age
```

### With Namespaces

**Traditional kubectl with custom-columns:**

```bash
kubectl get pods -n kube-system -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase
```

**With kubectl-columns:**

```bash
kubectl-columns pods name,status -n kube-system
```

## Getting Help

```bash
# General help
kubectl-columns help

# Resource-specific help
kubectl-columns help pods
kubectl-columns help deployments
```
