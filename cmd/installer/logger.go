package main

import (
	"log"
	"os"
)

// Log file for installation diagnostics
const logFile = "/tmp/tuinix-install.log"

var logger *log.Logger

func initLogger() {
	f, err := os.OpenFile(logFile, os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0644)
	if err != nil {
		// Fall back to stderr if we can't create log file
		logger = log.New(os.Stderr, "[tuinix] ", log.LstdFlags)
		return
	}
	logger = log.New(f, "", log.LstdFlags)
}

func logInfo(format string, args ...interface{}) {
	if logger != nil {
		logger.Printf("[INFO] "+format, args...)
	}
}

func logError(format string, args ...interface{}) {
	if logger != nil {
		logger.Printf("[ERROR] "+format, args...)
	}
}
