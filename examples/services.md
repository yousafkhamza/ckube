# Service Examples

## Traditional kubectl Commands

Get services with basic info:

```bash
kubectl get services -o=custom-columns=NAME:.metadata.name,TYPE:.spec.type,CLUSTER-IP:.spec.clusterIP
```

Get services with ports info:

```bash
kubectl get services -o=custom-columns=NAME:.metadata.name,PORTS:.spec.ports[*].port,TARGET-PORT:.spec.ports[*].targetPort
```

Get services with external IP and nodeport:

```bash
kubectl get services -o=custom-columns=NAME:.metadata.name,EXTERNAL-IP:.spec.externalIPs[0],NODEPORT:.spec.ports[*].nodePort
```

## With kubectl-columns Tool

Get services with name only (default):

```bash
kubectl-columns services
```

Get services with type and cluster IP:

```bash
kubectl-columns services name,type,clusterip
```

Get services with ports info:

```bash
kubectl-columns services name,ports,targetport
```

Get services with external IP and nodeport:

```bash
kubectl-columns services name,externalip,nodeport
```

Get services in specific namespace:

```bash
kubectl-columns services name,type -n kube-system
```

## Available Columns for Services

- `name`: Service name (.metadata.name)
- `type`: Service type (.spec.type)
- `clusterip`: Cluster IP (.spec.clusterIP)
- `externalip`: External IP if available (.spec.externalIPs[0])
- `ports`: Service ports (.spec.ports[*].port)
- `namespace`: Service namespace (.metadata.namespace)
- `age`: Creation timestamp (.metadata.creationTimestamp)
- `selector`: Service selector (.spec.selector)
- `targetport`: Target port (.spec.ports[*].targetPort)
- `nodeport`: Node port if applicable (.spec.ports[*].nodePort)
