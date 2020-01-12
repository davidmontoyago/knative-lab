package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	log.Print("handling request at /go/hello")
	fmt.Fprint(w, "Hello from Golang app!\n")
}

func main() {
	http.HandleFunc("/go/hello", handler)

	port := os.Getenv("API_PORT")
	log.Printf("starting golang helloworld on port %s...", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
