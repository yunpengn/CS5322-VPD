package iosafe

import (
	"fmt"
	"io"
)

// Close safely closes an object.
func Close(obj io.Closer) {
	if err := obj.Close(); err != nil {
		fmt.Printf("Unable to close object due to err=%s", err)
	}
}
