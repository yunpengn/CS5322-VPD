package dto

import (
	"errors"
	"time"
)

type HealthReq struct {
	Source string `form:"source"`
}

func (req *HealthReq) GetErrors() []error {
	var err []error
	if req.Source == "" {
		err = append(err, errors.New("cannot use empty source"))
	}
	return err
}

type HealthResp struct {
	Source    string    `json:"source"`
	Timestamp time.Time `json:"timestamp"`
}
