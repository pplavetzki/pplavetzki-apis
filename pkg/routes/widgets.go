package routes

import (
	"encoding/json"
	"net/http"
)

// Widget simple struct
type Widget struct {
	Name        string  `json:"name"`
	Description string  `json:"description"`
	Code        string  `json:"code"`
	Price       float64 `json:"price"`
}

// GetAllWidgets returns a list of widgets
func GetAllWidgets(w http.ResponseWriter, r *http.Request) {
	// A very simple health check.
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	var ws = []Widget{
		Widget{
			Name:        "Widget1",
			Description: "Simple widget 1",
			Code:        "W1",
			Price:       float64(2.34),
		},
		Widget{
			Name:        "Widget2",
			Description: "Simple widget 2",
			Code:        "W2",
			Price:       float64(42.40),
		},
	}
	json.NewEncoder(w).Encode(ws)
}
