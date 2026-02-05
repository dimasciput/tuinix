package main

import (
	"fmt"
	"math/rand"
	"os"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

func main() {
	initLogger()
	logInfo("tuinix installer started")

	if os.Geteuid() != 0 {
		fmt.Println(errorStyle.Render("! This installer must be run as root"))
		fmt.Println(grayStyle.Render("  Use: sudo installer"))
		os.Exit(1)
	}

	rand.Seed(time.Now().UnixNano())

	p := tea.NewProgram(initialModel(), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		logError("Program error: %v", err)
		fmt.Printf("Error: %v\n", err)
		os.Exit(1)
	}
	logInfo("Installer finished")
}
