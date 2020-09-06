package server

import (
	"github.com/gin-gonic/gin"
	"github.com/yunpengn/CS5322-VPD/common"
)

// Serve starts the server and makes it ready for serving all traffic.
func Serve() {
	// Loads the configuration.
	appConfig := LoadConfig()
	gin.SetMode(appConfig.Mode)

	// Registers all endpoints.
	router := gin.Default()
	route(router)

	// Runs the server.
	if err := router.Run(appConfig.Address); err != nil {
		common.Panic("Unable to start server due to err=%s", err)
	}
}

// route defines the routing configuration for all endpoints.
func route(r *gin.Engine) {
}
