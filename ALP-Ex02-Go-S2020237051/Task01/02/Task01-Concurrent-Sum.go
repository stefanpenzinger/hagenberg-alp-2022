package main

import (
	"Task01/01"
	"fmt"
	"sync"
	"time"
)

// Wait group for summing up total sum
var wg sync.WaitGroup

// Wait group for summing up sub sum
var wg2 sync.WaitGroup

func main() {
	totalSum := 0

	list := _1.RandArray(4)
	fmt.Println(list)

	then := time.Now()
	totalSum = concurrentSum(list, 1)

	fmt.Println("total_sum", totalSum, "calculated in", time.Since(then))

	then = time.Now()
	totalSum = concurrentSum(list, 2)
	fmt.Println("total_sum", totalSum, "calculated in", time.Since(then))
}

func concurrentSum(list []int, numberGoroutines int) int {
	returnValueChannel := make(chan int)
	totalSum := 0

	start := 0
	length := len(list)
	end := length / numberGoroutines
	rest := length % numberGoroutines

	// Add worker to calculate total sum
	wg.Add(1)
	go sumUp(returnValueChannel, &totalSum)

	for i := 1; i <= numberGoroutines; i++ {
		if i == 1 {
			start = 0
			end = end - 1
		} else {
			if rest == 0 {
				start = end + 1
				end = end + numberGoroutines
			} else {
				start = end + 1
				end = end + numberGoroutines + 1
				rest--
			}
		}

		// Add Workers to calculate Sub Sum
		wg2.Add(1)
		go calcSum(list, start, end, returnValueChannel)
	}

	// Wait until goroutines are finished with calculating sub sums
	wg2.Wait()
	// Close channel in order to force finish of Total Sum Wait Group
	close(returnValueChannel)
	// Wait until goroutines is finished with calculating total sum
	wg.Wait()

	return totalSum
}

func calcSum(list []int, start int, end int, channel chan int) {
	// Calculate sub sum
	defer wg2.Done()

	if end > len(list) {
		end = len(list)
	}

	sum := 0

	for i := start; i <= end; i++ {
		sum += list[i]
	}

	channel <- sum
}

func sumUp(channel chan int, totalSum *int) {
	// Iterate as long over channel input as channel is not closed
	defer wg.Done()

	for nextSum := range channel {
		fmt.Printf("SUMUP: %d\n", nextSum)
		*totalSum += nextSum
	}
}
