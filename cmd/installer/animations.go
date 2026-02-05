package main

import (
	"math/rand"
	"regexp"
	"strings"
)

func (m *model) initFireParticles() {
	m.fireParticles = make([]fireParticle, 200)
	for i := range m.fireParticles {
		m.fireParticles[i] = m.newFireParticle()
	}
}

func (m *model) newFireParticle() fireParticle {
	chars := []rune{'░', '▒', '▓', '█', '▄', '▀', '*', '.'}
	return fireParticle{
		x:       float64(m.width/2) + (rand.Float64()-0.5)*float64(m.width/3),
		y:       float64(m.height),
		vx:      (rand.Float64() - 0.5) * 2,
		vy:      -rand.Float64()*3 - 1,
		life:    rand.Float64() * 30,
		maxLife: 30,
		char:    chars[rand.Intn(len(chars))],
	}
}

// stripANSI removes ANSI escape sequences from a string
func stripANSI(s string) string {
	ansiRegex := regexp.MustCompile(`\x1b\[[0-9;]*[a-zA-Z]`)
	return ansiRegex.ReplaceAllString(s, "")
}

func (m *model) initGravityChars(content string) {
	// Strip ANSI codes before processing characters
	cleanContent := stripANSI(content)
	lines := strings.Split(cleanContent, "\n")
	m.physicsChars = nil

	for y, line := range lines {
		for x, ch := range line {
			if ch != ' ' && ch != '\n' {
				m.physicsChars = append(m.physicsChars, physicsChar{
					char:    ch,
					x:       float64(x),
					y:       float64(y),
					startX:  float64(x),
					startY:  float64(y),
					vx:      0,
					vy:      0,
					targetY: float64(m.height - 3),
					color:   colorOrange,
				})
			}
		}
	}
}
