package server

import (
	"net/http"

	"github.com/yunpengn/CS5322-VPD/common/logging"

	"github.com/yunpengn/CS5322-VPD/common/httpserver"
	"github.com/yunpengn/CS5322-VPD/dto"
	"github.com/yunpengn/CS5322-VPD/logic"
)

// Serve starts the server and makes it ready for serving all traffic.
func Serve() {
	// Loads the configuration and creates the server.
	appConfig := LoadConfig()

	// Initializes the logger.
	logging.Init(appConfig.Mode)

	// Creates a new server and registers all endpoints.
	server := httpserver.NewServer(appConfig.Mode, appConfig.Address)
	route(server)

	// Runs the server.
	server.Start()
}

// route defines the routing configuration for all endpoints.
func route(s *httpserver.Server) {
	s.Serve(http.MethodGet, "health", &dto.HealthReq{}, logic.HealthCheck)
}
