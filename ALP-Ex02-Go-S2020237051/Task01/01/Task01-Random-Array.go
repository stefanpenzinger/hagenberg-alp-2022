package _1

import (
	"fmt"
	"os"
	"time"
)
import "math/rand"

func RandArray(size int) []int {
	var arr []int = nil

	if size > 0 {
		arr = make([]int, size)

		rand.Seed(time.Now().UnixNano())

		for i := 0; i < size; i++ {
			arr[i] = rand.Intn(10-1+1) + 1
		}
	} else {
		fmt.Printf("Invalid array size %d!", size)
		os.Exit(1)
	}

	return arr
}

func printArray(arr []int) {
	for i := 0; i < len(arr); i++ {
		fmt.Println(arr[i])
	}
}
