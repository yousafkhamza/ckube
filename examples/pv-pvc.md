# Persistent Volume and PVC Examples

## Traditional kubectl Commands

### Persistent Volumes (PV)

Get PVs with basic info:

```bash
kubectl get pv -o=custom-columns=NAME:.metadata.name,CAPACITY:.spec.capacity.storage,STATUS:.status.phase
```

Get PVs with access modes and reclaim policy:

```bash
kubectl get pv -o=custom-columns=NAME:.metadata.name,ACCESS-MODES:.spec.accessModes[0],RECLAIM-POLICY:.spec.persistentVolumeReclaimPolicy
```

Get PVs with claim and storage class:

```bash
kubectl get pv -o=custom-columns=NAME:.metadata.name,CLAIM:.spec.claimRef.name,STORAGECLASS:.spec.storageClassName
```

### Persistent Volume Claims (PVC)

Get PVCs with basic info:

```bash
kubectl get pvc -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,VOLUME:.spec.volumeName
```

Get PVCs with capacity and access modes:

```bash
kubectl get pvc -o=custom-columns=NAME:.metadata.name,CAPACITY:.status.capacity.storage,ACCESS-MODES:.status.accessModes[0]
```

## With kubectl-columns Tool

### Persistent Volumes (PV)

Get PVs with name only (default):

```bash
kubectl-columns pv
```

Get PVs with capacity and status:

```bash
kubectl-columns pv name,capacity,status
```

Get PVs with access modes and reclaim policy:

```bash
kubectl-columns pv name,accessmodes,reclaimpolicy
```

Get PVs with claim and storage class:

```bash
kubectl-columns pv name,claim,storageclass
```

### Persistent Volume Claims (PVC)

Get PVCs with name only (default):

```bash
kubectl-columns pvc
```

Get PVCs with status and volume:

```bash
kubectl-columns pvc name,status,volume
```

Get PVCs with capacity and access modes:

```bash
kubectl-columns pvc name,capacity,accessmodes
```

Get PVCs in specific namespace:

```bash
kubectl-columns pvc name,status -n default
```

## Available Columns

### For Persistent Volumes (PV)

- `name`: PV name (.metadata.name)
- `capacity`: Storage capacity (.spec.capacity.storage)
- `accessmodes`: Access modes (.spec.accessModes[0])
- `reclaimpolicy`: Reclaim policy (.spec.persistentVolumeReclaimPolicy)
- `status`: Phase (.status.phase)
- `claim`: Associated claim (.spec.claimRef.name)
- `storageclass`: Storage class (.spec.storageClassName)
- `reason`: Status reason (.status.reason)

### For Persistent Volume Claims (PVC)

- `name`: PVC name (.metadata.name)
- `status`: Phase (.status.phase)
- `volume`: Volume name (.spec.volumeName)
- `capacity`: Storage capacity (.status.capacity.storage)
- `accessmodes`: Access modes (.status.accessModes[0])
- `namespace`: PVC namespace (.metadata.namespace)
- `storageclass`: Storage class (.spec.storageClassName)
