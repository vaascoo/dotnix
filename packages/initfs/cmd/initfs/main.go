package main

import (
	"log"
	"os"

	"github.com/alexflint/go-arg"
	"github.com/vaascoo/initfs/cmd/initfs/internal"
)

func main() {
	var args internal.Args
	args.Default()
	parser := arg.MustParse(&args)	
	if err := args.Run(); err != nil {
		log.Println(err)
		parser.WriteHelp(os.Stderr)
	}
}
