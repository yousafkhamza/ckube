# Basic Usage Examples

## Traditional kubectl vs ckube

### Pods Example

**Traditional kubectl with custom-columns:**

```bash
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName,IP:.status.podIP
```

**With ckube:**

```bash
ckube pods name,status,node,ip
```

### Deployments Example

**Traditional kubectl with custom-columns:**

```bash
kubectl get deployments -o=custom-columns=NAME:.metadata.name,READY:.status.readyReplicas,AVAILABLE:.status.availableReplicas,AGE:.metadata.creationTimestamp
```

**With ckube:**

```bash
ckube deployments name,ready,available,age
```

### With Namespaces

**Traditional kubectl with custom-columns:**

```bash
kubectl get pods -n kube-system -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase
```

**With ckube:**

```bash
ckube pods name,status -n kube-system
```

## Getting Help

```bash
# General help
ckube help

# Resource-specific help
ckube help pods
ckube help deployments
```
