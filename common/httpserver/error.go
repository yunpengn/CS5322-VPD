package httpserver

import (
	"encoding/json"
	"strings"

	"github.com/yunpengn/CS5322-VPD/common/errors"
)

// Error defines a common format for error response in any HTTP server.
type Error struct {
	Code       errors.ErrorCode `json:"errCode"`
	HttpStatus int              `json:"-"`
	Reasons    []error          `json:"reasons"`
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
		Code    errors.ErrorCode `json:"errCode"`
		Reasons []string         `json:"reasons"`
	}{
		Code:    e.Code,
		Reasons: reasons,
	})
}
