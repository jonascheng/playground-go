package main

import (
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"time"
)

func CreateDateDir(Path string, perm fs.FileMode) string {
	folderName := time.Now().Format("20060102")
	folderPath := filepath.Join(Path, folderName)
	os.MkdirAll(folderPath, perm)
	return folderPath
}

func CreateDateDirWithDifferentPerm() []string {
	path1 := CreateDateDir("/tmp/ModePerm", os.ModePerm)
	path2 := CreateDateDir("/tmp/ModeDir", os.ModeDir)
	path3 := CreateDateDir("/tmp/0555", 0555)

	return []string{path1, path2, path3}
}

func main() {
	fmt.Println(CreateDateDirWithDifferentPerm())
}
