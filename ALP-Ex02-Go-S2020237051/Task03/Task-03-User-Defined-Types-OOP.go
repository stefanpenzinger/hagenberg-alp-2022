package main

import (
	"fmt"
)

type point struct {
	x int
	y int
}

func (p point) String() string {
	return fmt.Sprintf("Origin (%d, %d)", p.x, p.y)
}

type rectangle struct {
	width  int
	height int
	origin point
}

func (r rectangle) Describe() string {
	return fmt.Sprintf("Drawing Rectangle(%s, %d, %d)", r.origin.String(), r.width, r.height)
}

type circle struct {
	radius int
	origin point
}

func (c circle) Describe() string {
	return fmt.Sprintf("Drawing Circle(%s, %d)", c.origin.String(), c.radius)
}

type geometry interface {
	Describe() string
}

type drawing struct {
	objects []geometry
}

func main() {
	rect := rectangle{
		width:  10,
		height: 10,
		origin: point{
			x: 5,
			y: 5,
		},
	}
	circ := circle{
		radius: 5,
		origin: point{
			x: 20,
			y: 20,
		},
	}
	// Create a new drawing and add objects
	drawing := drawing{objects: make([]geometry, 0)}
	drawing.objects = append(drawing.objects, rect)
	drawing.objects = append(drawing.objects, circ)
	// Draw / describe objects
	for _, obj := range drawing.objects {
		fmt.Println(obj.Describe())
	}
}
