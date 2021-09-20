package main

import (
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
	"log"
	"net/http"
	"os"
	"strings"
)

func files(w http.ResponseWriter, r *http.Request) {

	sess, _ := session.NewSession(&aws.Config{
		Region: aws.String(os.Getenv("REGION")),
		},
	)

	downloader := s3manager.NewDownloader(sess)
	
	s3File := strings.Split(r.URL.Path[1:], "/")[1]
	buf := aws.NewWriteAtBuffer([]byte{})
	_, err := downloader.Download(buf,
    &s3.GetObjectInput{
        Bucket: aws.String(os.Getenv("BUCKET")),
        Key:    aws.String(s3File),
    })
	if err != nil {
		log.Fatalf("Error %s file: %s", err, s3File)
	}

	w.WriteHeader(http.StatusOK)
	w.Write(buf.Bytes())
}

func main() {

    http.HandleFunc("/files/", files)
    log.Println("starting server on port 8080 ...")
    log.Fatal(http.ListenAndServe(":8080", nil))
}