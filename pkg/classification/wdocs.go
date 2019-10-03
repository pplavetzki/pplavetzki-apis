package classification

type tester struct {
	Name        string  `json:"name"`
	Description string  `json:"description"`
	Code        string  `json:"code"`
	Price       float64 `json:"price"`
}

// swagger:route GET / widget-tag get-all-widgets
// Gets all Widgets.
// responses:
//   200: widgetResponse

// This will return all of your trusty widgets
// swagger:response widgetResponse
type widgetResponse struct {
	// in:body
	Body []struct {
		Name        string
		Description string
		Code        string
		Price       float64
	}
}

// swagger:route GET /healthz health-check get-healthz
// This verifies the health of the container
//     Schemes: http
// 		responses:
//   		200: healthzResponse

// This returns the health of the api server
// swagger:response healthzResponse
type healthzResponse struct {
	// in:body
	Body struct {
		Alive bool
	}
}
