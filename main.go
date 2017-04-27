package main

import "fmt"

func main() {
	var str string
	str += "zero"
	str += "first"
	str += "second"
	str += "third"
	str +="fore"
	str += "five"
	str += "six"
	str += "seven"
	str += "eight"
	str += "nine"
	str += "ten"
	fmt.Println(fmt.Sprintf("str[%d]=%s", len(str), str))
}


