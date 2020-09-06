package common

import (
	"fmt"
)

// Panic throws a panic with the formatting.
func Panic(format string, obj ...interface{}) {
	msg := fmt.Sprintf(format, obj...)
	panic(msg)
}
