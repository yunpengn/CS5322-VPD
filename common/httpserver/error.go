package httpserver

import (
	"encoding/json"
	"strings"
)

// Error defines a common format for error response in any HTTP server.
type Error struct {
	ErrCode    int     `json:"errCode"`
	HttpStatus int     `json:"-"`
	Reasons    []error `json:"reasons"`
}

// Error implements the error interface.
func (e *Error) Error() string {
	var builder strings.Builder
	for _, reason := range e.Reasons {
		builder.WriteString(reason.Error())
	}
	return builder.String()
}

// MarshalJSON implements the json.Marshaler interface.
func (e *Error) MarshalJSON() ([]byte, error) {
	reasons := make([]string, 0, len(e.Reasons))
	for _, err := range e.Reasons {
		reasons = append(reasons, err.Error())
	}

	return json.Marshal(&struct {
		ErrCode int      `json:"errCode"`
		Reasons []string `json:"reasons"`
	}{
		ErrCode: e.ErrCode,
		Reasons: reasons,
	})
}
