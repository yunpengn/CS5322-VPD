package server

import (
	"io/ioutil"

	"github.com/yunpengn/CS5322-VPD/common"
	"github.com/yunpengn/CS5322-VPD/common/system"
)

// AppConfig defines the structure of the application configuration.
type AppConfig struct {
	Address string      `json:"address"`
	Mode    system.Mode `json:"mode"`
}

const (
	defaultConfigPath = "config.json"
)

// LoadConfig loads the app configuration from the local file at the default location.
func LoadConfig() *AppConfig {
	// Opens the config file and reads content.
	file, err := ioutil.ReadFile(defaultConfigPath)
	if err != nil {
		common.Panic("Unable to read config file at %s due to err=%s", defaultConfigPath, err)
	}
	content := string(file)

	// Unmarshalls the file content.
	appConfig := &AppConfig{}
	common.UnmarshalJSON(content, appConfig)
	return appConfig
}
