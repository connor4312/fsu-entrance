package main

import (
"fmt"
"encoding/json"
"io/ioutil"
"log"
"os"
"strings"
"strconv"
"bufio"
)

type IpData struct {
	First string `json:"first_ip"`
	Last string 	`json:"last_ip"`
	Country string 	`json:"country"`
}

var dat []IpData

func main(){
dat = make([]IpData,0)
b, err := ioutil.ReadFile("source.json")
if (err != nil){
	log.Fatal(err)
	return
}
json.Unmarshal(b,&dat)
reader := bufio.NewReader(os.Stdin)
input, _ := reader.ReadString('\n')
args := strings.Split(strings.Replace(input,"\n","",-1)," ")
	if args[0] == "list"{
		fmt.Println(args[1]);
		for _,ip := range dat {
			fmt.Println(ip.Country)
			if (ip.Country != args[1]) { continue }
			first := strings.Split(ip.First,".");
			last := strings.Split(ip.Last,".");
			var firstip int = (parse(first[0]) << 24 | parse(first[1]) << 16 | parse(first[2]) << 8 | parse(first[3]));
			var lastip int = (parse(last[0]) << 24 | parse(last[1]) << 16 | parse(last[2]) << 8 | parse(last[3]));
			for i := firstip; i < lastip; i++ {
				fmt.Printf("%d.%d.%d.%d \n",(i >> 24) & 0xF,(i >> 16) & 0xFF,(i >> 8) & 0xFF, i & 0xFF);
			}
		}
	} else if (args[0] == "entries"){
		for _,ip := range dat{
			fmt.Printf("first_ip: %s , last_ip: %s, country: %s \n",ip.First,ip.Last,ip.Country);
		}
	} else if (args[0] == "locate"){
		usrip := strings.Split(args[1],".");
		var usripint int = (parse(usrip[0]) << 24 | parse(usrip[1]) << 16 | parse(usrip[2]) << 8 | parse(usrip[3]));
		for _,ip := range dat {
			first := strings.Split(ip.First,".");
			last := strings.Split(ip.Last,".");
			var firstip int = (parse(first[0]) << 24 | parse(first[1]) << 16 | parse(first[2]) << 8 | parse(first[3]));
			var lastip int = (parse(last[0]) << 24 | parse(last[1]) << 16 | parse(last[2]) << 8 | parse(last[3]));
			if usripint > firstip && usripint < lastip{
				fmt.Printf("Country %s \n", ip.Country);
			}
		}
	}
}

func parse(what string) int{
	i, err := strconv.Atoi(what);
	if err != nil{
		return -1
	} else {
		return i
	}
}

