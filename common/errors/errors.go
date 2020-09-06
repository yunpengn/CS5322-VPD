package errors

// ErrorCode defines a unique code to be returned in API response.
type ErrorCode string

var (
	// Cxxx stands for client error.
	CannotUnmarshal   = register("C001")
	InvalidRequest    = register("C002")
	MissingCredential = register("C003")
	NoPermissionScope = register("C004")
	NotFound          = register("C005")

	// Sxxx stands for server error.
	UnknownServerError = register("S001")
)

// register creates a new error code.
func register(code string) ErrorCode {
	return ErrorCode(code)
}
