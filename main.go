package main

import (
	"fmt"
	"io"
	"log"
	"net/http"

	"pplavetzki-apis/pkg/routes"

	"github.com/gorilla/mux"
)

func healthCheckHandler(w http.ResponseWriter, r *http.Request) {
	// A very simple health check.
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	// In the future we could report back on the status of our DB, or our cache
	// (e.g. Redis) by performing a simple PING, and include them in the response.
	io.WriteString(w, `{"alive": true}`)
}

func handlerRequests() {
	r := mux.NewRouter().StrictSlash(true)
	r.HandleFunc("/healthz", healthCheckHandler).Methods(http.MethodGet)
	r.HandleFunc("/", routes.GetAllWidgets).Methods(http.MethodGet)

	log.Fatal(http.ListenAndServe(":8080", r))
}

func main() {
	fmt.Println("Rest API v0.1.0 - pplavetzki APIS")
	handlerRequests()
}
