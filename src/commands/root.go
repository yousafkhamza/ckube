package commands

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
    Use:   "kubectl-columns",
    Short: "A tool for managing custom columns in kubectl",
    Long:  `kubectl-columns is a command-line tool that helps you manage and query custom columns for kubectl commands.`,
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Welcome to kubectl-columns! Use 'kubectl-columns help' for more information.")
    },
}

func Execute() {
    if err := rootCmd.Execute(); err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
}

func init() {
    // Define any global flags or configuration here
}