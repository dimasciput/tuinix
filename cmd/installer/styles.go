package main

import (
	_ "embed"

	"github.com/charmbracelet/lipgloss"
)

// Brand colors - used sparingly for emphasis
var (
	colorOrange   = lipgloss.Color("#E95420") // Primary brand accent
	colorNixBlue  = lipgloss.Color("#5277C3") // Info accent
	colorGreen    = lipgloss.Color("#28A745") // Success
	colorRed      = lipgloss.Color("#DC3545") // Errors
	colorAmber    = lipgloss.Color("#FFC107") // Warnings
	colorEarth    = lipgloss.Color("#654321") // Details
	colorOffWhite = lipgloss.Color("#D4D4D4") // Default text
	colorDimGray  = lipgloss.Color("#808080") // Secondary text
	colorDarkGray = lipgloss.Color("#555555") // Borders, subtle elements
)

// Embedded catimg-rendered mascot logos (24-bit ANSI color)
//
//go:embed logo-header.txt
var mascotLogo string

//go:embed logo-large.txt
var mascotLogoLarge string

//go:embed version.txt
var versionInfo string

// Figlet-style TUINIX title
const tuinixTitle = `████████╗██╗   ██╗██╗███╗   ██╗██╗██╗  ██╗
╚══██╔══╝██║   ██║██║████╗  ██║██║╚██╗██╔╝
   ██║   ██║   ██║██║██╔██╗ ██║██║ ╚███╔╝
   ██║   ██║   ██║██║██║╚██╗██║██║ ██╔██╗
   ██║   ╚██████╔╝██║██║ ╚████║██║██╔╝ ██╗
   ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝`

// Styles - off-white text by default, color only for emphasis
var (
	titleStyle = lipgloss.NewStyle().
			Foreground(colorOrange).
			Bold(true)

	promptStyle = lipgloss.NewStyle().
			Foreground(colorOffWhite).
			Bold(true)

	successStyle = lipgloss.NewStyle().
			Foreground(colorGreen)

	errorStyle = lipgloss.NewStyle().
			Foreground(colorRed)

	warningStyle = lipgloss.NewStyle().
			Foreground(colorAmber)

	detailStyle = lipgloss.NewStyle().
			Foreground(colorDimGray)

	grayStyle = lipgloss.NewStyle().
			Foreground(colorDimGray)

	borderStyle = lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(colorDarkGray)

	headerTitleStyle = lipgloss.NewStyle().
				Foreground(colorNixBlue).
				Bold(true)

	stepStyle = lipgloss.NewStyle().
			Foreground(colorOffWhite).
			Bold(true).
			Align(lipgloss.Center)

	footerStyle = lipgloss.NewStyle().
			Foreground(colorDimGray).
			Align(lipgloss.Center)
)
