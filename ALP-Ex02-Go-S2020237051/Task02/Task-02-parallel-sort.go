package main

import (
	"fmt"
	"math/rand"
	"os"
	"runtime"
	"sync"
	"time"
)

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

func main() {
	arr := RandArray(100)

	mergeSortPar(arr, 3)
}

func mergeSortPar(s []int, numberGoRoutines int) {
	// We subtract 1 goroutine which is the one we are already running in.
	extraGoroutines := runtime.NumCPU() - 1
	semChan := make(chan struct{}, extraGoroutines)
	defer close(semChan)
	mergeSortParImpl(s, semChan)
}

func mergeSortParImpl(src []int, semChan chan struct{}) {
	if len(src) <= 1 {
		return
	}

	middle := len(src) / 2

	left := make([]int, middle)
	right := make([]int, len(src)-middle)
	copy(left, src[:middle])
	copy(right, src[middle:])

	wg := sync.WaitGroup{}

	select {
	case semChan <- struct{}{}:
		wg.Add(1)
		go func() {
			mergeSortParImpl(left, semChan)
			<-semChan
			wg.Done()
		}()
	default:
		// Can't create a new goroutine, let's do the job ourselves.
		mergeSortParImpl(left, semChan)
	}

	mergeSortParImpl(right, semChan)

	wg.Wait()

	merge(src, left, right)
}
