package main

import "fmt"

func main() {
	var str string
	str += "zero"
	str += "zero"
	str += "zero"
	str += "zero"
	str += "zero"
	str += "zero"
	str += sample()
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

func sample() string {
	return "aaa"
}

func getFuga() string {
	return "fuga"
}

func getHoge() string {
	return "hoge"
}

func getPiyo() string {
	return "piyoyo"
}

