package httpserver

import (
	"net/http"
	"reflect"

	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/yunpengn/CS5322-VPD/common"
	"github.com/yunpengn/CS5322-VPD/common/logging"
	"github.com/yunpengn/CS5322-VPD/common/system"
)

// Server defines the standard HTTP server object.
type Server struct {
	engine *gin.Engine
	addr   string
	mode   system.Mode
}

// HandlerFunc defines the method signature for an endpoint handler.
type HandlerFunc func(request ValidatedRequest) (interface{}, *Error)

// NewServer creates a new server.
func NewServer(mode system.Mode, addr string) *Server {
	// Sets the system mode.
	gin.SetMode(toGinMode(mode))

	// Redirects logging to files if not in development mode.
	if mode != system.Local {
		gin.DefaultWriter = logging.LogWriter
		gin.DefaultErrorWriter = logging.ErrWriter
	}

	return &Server{
		engine: gin.Default(),
		addr:   addr,
		mode:   mode,
	}
}

// Serve registers the routing for a given endpoint.
func (s *Server) Serve(method string, path string, req ValidatedRequest, handler HandlerFunc) {
	// Gets the underlying type of the request object.
	reqType := reflect.ValueOf(req).Elem().Type()

	s.engine.Handle(method, path, func(ctx *gin.Context) {
		// Creates a new instance of the DTO object.
		request := reflect.New(reqType).Interface().(ValidatedRequest)

		// Binds the request to the given DTO object.
		if err := ctx.ShouldBindWith(request, toBindingType(method)); err != nil {
			ctx.AbortWithStatusJSON(http.StatusBadRequest, &Error{
				Reasons: []error{err},
			})
			return
		}

		// Validates the incoming request.
		if errors := request.GetErrors(); errors != nil && len(errors) != 0 {
			ctx.AbortWithStatusJSON(http.StatusBadRequest, &Error{
				Reasons: errors,
			})
			return
		}

		// Processes the request and sends response.
		resp, err := handler(request)
		if err != nil {
			ctx.AbortWithStatusJSON(err.HttpStatus, err)
			return
		} else if resp == nil {
			ctx.JSON(http.StatusNoContent, resp)
		}
		ctx.JSON(http.StatusOK, resp)
	})
}

func (s *Server) Start() {
	// Runs the engine.
	err := s.engine.Run(s.addr)
	if err != nil {
		common.Panic("Unable to start server due to %s", err)
	}
}

func toGinMode(mode system.Mode) string {
	switch mode {
	case system.Production:
		return gin.ReleaseMode
	case system.Staging:
		return gin.TestMode
	case system.Local:
		return gin.DebugMode
	default:
		common.Panic("Invalid mode %s specified in configuration", mode)
		return ""
	}
}

func toBindingType(method string) binding.Binding {
	switch method {
	case http.MethodGet:
		return binding.Query
	default:
		return binding.JSON
	}
}
