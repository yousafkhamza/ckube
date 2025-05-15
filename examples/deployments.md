# Deployment Examples

## Traditional kubectl Commands

Get deployments with basic info:

```bash
kubectl get deployments -o=custom-columns=NAME:.metadata.name,READY:.status.readyReplicas,UP-TO-DATE:.status.updatedReplicas,AVAILABLE:.status.availableReplicas
```

Get deployments with replicas and strategy:

```bash
kubectl get deployments -o=custom-columns=NAME:.metadata.name,REPLICAS:.spec.replicas,STRATEGY:.spec.strategy.type
```

Get deployments with container info:

```bash
kubectl get deployments -o=custom-columns=NAME:.metadata.name,CONTAINERS:.spec.template.spec.containers[*].name
```

## With ckube Tool

Get deployments with name only (default):

```bash
ckube deployments
```

Get deployments with ready, up-to-date, and available replicas:

```bash
ckube deployments name,ready,uptodate,available
```

Get deployments with replica count and strategy:

```bash
ckube deployments name,replicas,strategy
```

Get deployments with container info:

```bash
ckube deployments name,containers
```

Get deployments in specific namespace:

```bash
ckube deployments name,ready -n kube-system
```

## Available Columns for Deployments

- `name`: Deployment name (.metadata.name)
- `ready`: Ready replicas (.status.readyReplicas)
- `uptodate`: Up-to-date replicas (.status.updatedReplicas)
- `available`: Available replicas (.status.availableReplicas)
- `namespace`: Deployment namespace (.metadata.namespace)
- `age`: Creation timestamp (.metadata.creationTimestamp)
- `replicas`: Desired replicas (.spec.replicas)
- `strategy`: Deployment strategy (.spec.strategy.type)
- `containers`: Container names (.spec.template.spec.containers[*].name)
