package main

import (
	"bytes"
	"fmt"
	"net"
	"os"
	"os/exec"
	"regexp"
	"strings"
	"time"

	tea "github.com/charmbracelet/bubbletea"
)

func tick() tea.Cmd {
	return tea.Tick(time.Millisecond*33, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

func checkNetwork() tea.Cmd {
	return func() tea.Msg {
		conn, err := net.DialTimeout("tcp", "github.com:443", 5*time.Second)
		if err != nil {
			return networkCheckMsg{ok: false}
		}
		conn.Close()
		return networkCheckMsg{ok: true}
	}
}

func pollLogTail(isZFS bool) tea.Cmd {
	return func() tea.Msg {
		time.Sleep(time.Second)
		data, err := os.ReadFile(logFile)
		if err != nil {
			return logTailMsg{lines: nil, currentStep: -1}
		}
		content := strings.TrimSpace(string(data))
		lines := strings.Split(content, "\n")
		start := len(lines) - 3
		if start < 0 {
			start = 0
		}

		// Parse log to determine current step based on "Step X complete" messages
		// The log writes "Step X complete" after each step finishes
		currentStep := 0
		stepCompleteRe := regexp.MustCompile(`Step (\d+) complete`)
		for _, line := range lines {
			if matches := stepCompleteRe.FindStringSubmatch(line); len(matches) > 1 {
				var step int
				fmt.Sscanf(matches[1], "%d", &step)
				if step > currentStep {
					currentStep = step
				}
			}
		}

		return logTailMsg{lines: lines[start:], currentStep: currentStep}
	}
}

func runCommand(name string, args ...string) (string, error) {
	cmdStr := name + " " + strings.Join(args, " ")
	logInfo("Running command: %s", cmdStr)

	cmd := exec.Command(name, args...)
	var stdout, stderr bytes.Buffer
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	err := cmd.Run()
	output := stdout.String() + stderr.String()

	if err != nil {
		logError("Command failed: %s\nError: %v\nOutput: %s", cmdStr, err, output)
	} else {
		logInfo("Command succeeded: %s", cmdStr)
		if output != "" {
			logInfo("Output: %s", output)
		}
	}
	return output, err
}
