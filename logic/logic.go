package logic

import (
	"github.com/yunpengn/CS5322-VPD/common/httpserver"
	"github.com/yunpengn/CS5322-VPD/dto"
)

func HealthCheck(request httpserver.ValidatedRequest) (interface{}, *httpserver.Error) {
	req := request.(*dto.HealthReq)

	return &dto.HealthResp{
		Source: req.Source,
	}, nil
}
