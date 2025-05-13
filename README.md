# kubectl-columns Tool

## Overview

The `kubectl-columns` tool is designed to enhance the usability of `kubectl` by allowing users to easily specify custom columns for Kubernetes resources. This tool eliminates the need to remember complex JSONPath expressions for custom column output formats.

## Features

- Direct execution of kubectl with custom columns without memorizing JSONPath syntax
- Support for multiple resource types (pods, deployments, services, nodes, pv, pvc)
- Namespace support via -n/--namespace flag
- Comprehensive help system with resource-specific column documentation
- Simple, intuitive command syntax

## Installation

### Option 1: Direct Install Script (Recommended)

Install kubectl-columns with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/yousafkhamza/kubectl-columns/main/install.sh | bash
```

### Option 2: Using Go (for Go users)

```bash
go install github.com/yousafkhamza/kubectl-columns@latest
```

### Option 3: Manual Download

1. Download the latest binary for your platform from [GitHub Releases](https://github.com/yousafkhamza/kubectl-columns/releases/latest)
2. Make it executable: `chmod +x kubectl-columns`
3. Move it to your PATH: `sudo mv kubectl-columns /usr/local/bin/`

### Option 4: Build from Source

```bash
# Clone the repository
git clone https://github.com/yousafkhamza/kubectl-columns.git
cd kubectl-columns

# Build the tool
make build

# Install to your PATH
make install
```

## Usage

After installation, you can use the tool with the following syntax:

```
kubectl-columns RESOURCE [COLUMNS] [-n NAMESPACE]
```

### Parameters

- `RESOURCE`: The Kubernetes resource type (pods, deployments, services, etc.)
- `COLUMNS`: Comma-separated list of columns to display (e.g., name,status,ip)
- `-n NAMESPACE`: Optional namespace specification

### Commands

- `help`: Display general help information
- `help [RESOURCE]`: Display available columns for a specific resource

### Examples

```bash
# Show default columns (name) for pods
kubectl-columns pods

# Show specific columns for pods
kubectl-columns pods name,status,ip

# Show pods in a specific namespace
kubectl-columns pods name,ip -n kube-system

# Get help for a specific resource
kubectl-columns help pods
```

### Supported Resources and Columns

#### Pods

- name, status, node, ip, namespace, age, ready, restarts, image

#### Deployments

- name, ready, uptodate, available, namespace, age, replicas, strategy, containers

#### Services

- name, type, clusterip, externalip, ports, namespace, age, selector, targetport, nodeport

#### Nodes

- name, status, roles, internalip, externalip, version, os, kernel, cpu, memory

#### Persistent Volumes (pv)

- name, capacity, accessmodes, reclaimpolicy, status, claim, storageclass, reason

#### Persistent Volume Claims (pvc)

- name, status, volume, capacity, accessmodes, namespace, storageclass

## Author

Created by [Yousaf K Hamza](https://github.com/yousafkhamza)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-yousafkhamza-blue)](https://linkedin.com/in/yousafkhamza)
[![GitHub](https://img.shields.io/badge/GitHub-yousafkhamza-darkgreen)](https://github.com/yousafkhamza)

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
