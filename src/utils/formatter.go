package utils

import (
	"fmt"
	"strings"
)

// FormatCustomColumns formats the output based on the provided custom column template and data.
func FormatCustomColumns(template string, data map[string]interface{}) string {
	var formattedColumns []string
	columns := strings.Split(template, ",")

	for _, column := range columns {
		column = strings.TrimSpace(column)
		if value, exists := data[column]; exists {
			formattedColumns = append(formattedColumns, fmt.Sprintf("%s: %v", column, value))
		} else {
			formattedColumns = append(formattedColumns, fmt.Sprintf("%s: N/A", column))
		}
	}

	return strings.Join(formattedColumns, " | ")
}

// Example usage of FormatCustomColumns
func ExampleFormatCustomColumns() {
	template := "name, status, age"
	data := map[string]interface{}{
		"name":   "example-pod",
		"status": "Running",
		"age":    "5m",
	}

	result := FormatCustomColumns(template, data)
	fmt.Println(result) // Output: name: example-pod | status: Running | age: 5m
}