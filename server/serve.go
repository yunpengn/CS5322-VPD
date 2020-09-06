package server

import (
	"github.com/gin-gonic/gin"
)

// Serve starts the server and makes it ready for serving all traffic.
func Serve() {
	// Registers all endpoints.
	router := gin.Default()
	route(router)

	// Runs the server.
	_ = router.Run(":8080")
}

// route defines the routing configuration for all endpoints.
func route(router *gin.Engine) {

}
