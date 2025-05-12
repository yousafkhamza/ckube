/*
kubectl-columns: A tool to simplify kubectl custom columns output

Author: Yousaf K Hamza
GitHub: https://github.com/yousafkhamza
LinkedIn: https://linkedin.com/in/yousafkhamza

Copyright (c) 2025 Yousaf K Hamza
*/

package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Column definitions for different resource types
var columnDefinitions = map[string]map[string]string{
    "pods": {
        "name":      ".metadata.name",
        "status":    ".status.phase",
        "node":      ".spec.nodeName",
        "ip":        ".status.podIP",
        "namespace": ".metadata.namespace",
        "age":       ".metadata.creationTimestamp",
        "ready":     ".status.conditions[?(@.type==\"Ready\")].status",
        "restarts":  ".status.containerStatuses[0].restartCount",
        "image":     ".spec.containers[0].image",
    },
    "deployments": {
        "name":       ".metadata.name",
        "ready":      ".status.readyReplicas",
        "uptodate":   ".status.updatedReplicas",
        "available":  ".status.availableReplicas",
        "namespace":  ".metadata.namespace",
        "age":        ".metadata.creationTimestamp",
        "replicas":   ".spec.replicas",
        "strategy":   ".spec.strategy.type",
        "containers": ".spec.template.spec.containers[*].name",
    },
    "services": {
        "name":        ".metadata.name",
        "type":        ".spec.type",
        "clusterip":   ".spec.clusterIP",
        "externalip":  ".spec.externalIPs[0]",
        "ports":       ".spec.ports[*].port",
        "namespace":   ".metadata.namespace",
        "age":         ".metadata.creationTimestamp",
        "selector":    ".spec.selector",
        "targetport":  ".spec.ports[*].targetPort",
        "nodeport":    ".spec.ports[*].nodePort",
    },
    "nodes": {
        "name":       ".metadata.name",
        "status":     ".status.conditions[?(@.type==\"Ready\")].status",
        "roles":      ".metadata.labels.kubernetes\\.io/role",
        "internalip": ".status.addresses[?(@.type==\"InternalIP\")].address",
        "externalip": ".status.addresses[?(@.type==\"ExternalIP\")].address",
        "version":    ".status.nodeInfo.kubeletVersion",
        "os":         ".status.nodeInfo.osImage",
        "kernel":     ".status.nodeInfo.kernelVersion",
        "cpu":        ".status.capacity.cpu",
        "memory":     ".status.capacity.memory",
    },
    "pv": {
        "name":          ".metadata.name",
        "capacity":      ".spec.capacity.storage",
        "accessmodes":   ".spec.accessModes[0]",
        "reclaimpolicy": ".spec.persistentVolumeReclaimPolicy",
        "status":        ".status.phase",
        "claim":         ".spec.claimRef.name",
        "storageclass":  ".spec.storageClassName",
        "reason":        ".status.reason",
    },
    "pvc": {
        "name":         ".metadata.name",
        "status":       ".status.phase",
        "volume":       ".spec.volumeName",
        "capacity":     ".status.capacity.storage",
        "accessmodes":  ".status.accessModes[0]",
        "namespace":    ".metadata.namespace",
        "storageclass": ".spec.storageClassName",
    },
}

func main() {
    if len(os.Args) < 2 {
        printHelp()
        os.Exit(1)
    }

    // Handle help command
    if os.Args[1] == "help" || os.Args[1] == "--help" || os.Args[1] == "-h" {
        if len(os.Args) > 2 {
            printResourceHelp(os.Args[2])
        } else {
            printHelp()
        }
        return
    }

    // Get resource type
    resourceType := os.Args[1]
    columns, ok := columnDefinitions[resourceType]
    if !ok {
        fmt.Printf("Unsupported resource type: %s\n", resourceType)
        fmt.Println("Supported resources:", getSupportedResources())
        os.Exit(1)
    }

    // Default columns to show if none specified
    columnsToShow := []string{"name"}
    namespace := ""
    
    // Parse arguments
    for i := 2; i < len(os.Args); i++ {
        arg := os.Args[i]
        
        // Handle namespace flag
        if arg == "-n" || arg == "--namespace" {
            if i+1 < len(os.Args) {
                namespace = os.Args[i+1]
                i++ // Skip the next arg which is the namespace value
            } else {
                fmt.Println("Error: Namespace flag requires a value")
                os.Exit(1)
            }
            continue
        }
        
        // Assume it's a column list
        columnsToShow = strings.Split(arg, ",")
        break
    }

    // Build column formats
    columnFormats := []string{}
    for _, col := range columnsToShow {
        col = strings.ToLower(col)
        if path, exists := columns[col]; exists {
            columnFormats = append(columnFormats, fmt.Sprintf("%s:%s", strings.ToUpper(col), path))
        } else {
            fmt.Printf("Unknown column '%s' for resource type '%s'\n", col, resourceType)
            fmt.Printf("Available columns for %s: %s\n", resourceType, getAvailableColumns(columns))
            os.Exit(1)
        }
    }

    // Build kubectl command
    args := []string{"get", resourceType}
    if namespace != "" {
        args = append(args, "-n", namespace)
    }
    args = append(args, "-o=custom-columns=" + strings.Join(columnFormats, ","))

    // Execute kubectl command
    cmd := exec.Command("kubectl", args...)
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    err := cmd.Run()
    if err != nil {
        fmt.Printf("Error executing kubectl: %v\n", err)
        os.Exit(1)
    }
}

func getAvailableColumns(columns map[string]string) string {
    keys := []string{}
    for k := range columns {
        keys = append(keys, k)
    }
    return strings.Join(keys, ", ")
}

func getSupportedResources() string {
    resources := []string{}
    for r := range columnDefinitions {
        resources = append(resources, r)
    }
    return strings.Join(resources, ", ")
}

func printHelp() {
    fmt.Println("kubectl-columns - A tool to simplify kubectl custom columns output")
    fmt.Println("\nUsage:")
    fmt.Println("  kubectl-columns RESOURCE [COLUMNS] [-n NAMESPACE]")
    fmt.Println("\nExamples:")
    fmt.Println("  kubectl-columns pods                   # Show pod names")
    fmt.Println("  kubectl-columns pods name,status,ip    # Show pod names, statuses and IPs")
    fmt.Println("  kubectl-columns pods name,ip -n kube-system  # Show names and IPs in the kube-system namespace")
    fmt.Println("\nSupported resources:")
    fmt.Println("  " + getSupportedResources())
    fmt.Println("\nCommands:")
    fmt.Println("  help [RESOURCE]    # Show help for specific resource")
    fmt.Println("\nUse 'kubectl-columns help RESOURCE' to see available columns for a resource")
}

func printResourceHelp(resource string) {
    columns, ok := columnDefinitions[resource]
    if !ok {
        fmt.Printf("Unsupported resource type: %s\n", resource)
        fmt.Println("Supported resources:", getSupportedResources())
        return
    }

    fmt.Printf("Available columns for %s:\n", resource)
    fmt.Println(getAvailableColumns(columns))
    fmt.Println("\nExamples:")
    fmt.Printf("  kubectl-columns %s name,status     # Show names and statuses\n", resource)
    fmt.Printf("  kubectl-columns %s name -n default # Show names in default namespace\n", resource)
}