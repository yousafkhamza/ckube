# Node Examples

## Traditional kubectl Commands

Get nodes with basic info:

```bash
kubectl get nodes -o=custom-columns=NAME:.metadata.name,STATUS:.status.conditions[?(@.type=="Ready")].status
```

Get nodes with IP addresses:

```bash
kubectl get nodes -o=custom-columns=NAME:.metadata.name,INTERNAL-IP:.status.addresses[?(@.type=="InternalIP")].address,EXTERNAL-IP:.status.addresses[?(@.type=="ExternalIP")].address
```

Get nodes with version info:

```bash
kubectl get nodes -o=custom-columns=NAME:.metadata.name,VERSION:.status.nodeInfo.kubeletVersion,OS:.status.nodeInfo.osImage
```

Get nodes with resource capacity:

```bash
kubectl get nodes -o=custom-columns=NAME:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory
```

## With ckube Tool

Get nodes with name only (default):

```bash
ckube nodes
```

Get nodes with status and roles:

```bash
ckube nodes name,status,roles
```

Get nodes with IP addresses:

```bash
ckube nodes name,internalip,externalip
```

Get nodes with version and OS info:

```bash
ckube nodes name,version,os,kernel
```

Get nodes with resource capacity:

```bash
ckube nodes name,cpu,memory
```

## Available Columns for Nodes

- `name`: Node name (.metadata.name)
- `status`: Ready status (.status.conditions[?(@.type=="Ready")].status)
- `roles`: Node roles (.metadata.labels.kubernetes\.io/role)
- `internalip`: Internal IP (.status.addresses[?(@.type=="InternalIP")].address)
- `externalip`: External IP (.status.addresses[?(@.type=="ExternalIP")].address)
- `version`: Kubelet version (.status.nodeInfo.kubeletVersion)
- `os`: Operating system (.status.nodeInfo.osImage)
- `kernel`: Kernel version (.status.nodeInfo.kernelVersion)
- `cpu`: CPU capacity (.status.capacity.cpu)
- `memory`: Memory capacity (.status.capacity.memory)
