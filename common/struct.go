package common

import (
	"encoding/json"
	"fmt"
)

// MarshalJSON encodes a given object into string.
func MarshalJSON(obj interface{}) string {
	output, err := json.Marshal(obj)
	if err != nil {
		fmt.Printf("Unable to marshal obj=%#v due to err=%s", obj, err)
	}
	return string(output)
}

// UnmarshalJSON decodes a given string into the given object.
func UnmarshalJSON(str string, obj interface{}) {
	if err := json.Unmarshal([]byte(str), obj); err != nil {
		fmt.Printf("Unable to unmarshal str=%s due to err=%s", str, err)
	}
}
