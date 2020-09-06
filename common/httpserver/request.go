package httpserver

// ValidatedRequest defines the request interface with validation.
type ValidatedRequest interface {
	GetErrors() []error
}
