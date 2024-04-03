package main

func main() {
	arr := RandArray(100)

	mergeSortSeq(arr)
}

func mergeSortSeq(s []int) {
	if len(s) == 1 {
		return
	}

	middle := len(s) / 2

	left := make([]int, middle)
	right := make([]int, len(s)-middle)
	copy(left, s[:middle])
	copy(right, s[middle:])

	mergeSortSeq(left)
	mergeSortSeq(right)
	merge(s, left, right)
}

func merge(result []int, left []int, right []int) {
	i := 0
	leftStart := 0
	rightStart := 0

	for leftStart < len(left) || rightStart < len(right) {
		if leftStart < len(left) && rightStart < len(right) {
			if left[leftStart] <= right[rightStart] {
				result[i] = left[leftStart]
				leftStart++
			} else {
				result[i] = right[rightStart]
				rightStart++
			}
		} else if leftStart < len(left) {
			result[i] = left[leftStart]
			leftStart++
		} else if rightStart < len(right) {
			result[i] = right[rightStart]
			rightStart++
		}
		i++
	}
}
