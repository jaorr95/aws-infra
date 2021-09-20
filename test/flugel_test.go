package test

import (
	"fmt"
	httphelper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strconv"
	"testing"
	"time"
)

func TestFlugel(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../flugel",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	validateWebServer(t, terraformOptions)
	
}

func validateWebServer(t *testing.T, opts *terraform.Options) {

	url := terraform.Output(t, opts, "dns_alb")
	contentS3 := terraform.Output(t, opts, "content_files_s3")
	filesQuantity, _ := strconv.Atoi(terraform.Output(t, opts, "object_files_quantity"))
	for i := 1; i <= filesQuantity; i++ {
		httphelper.HttpGetWithRetry(t, fmt.Sprintf("http://%s/files/file%d.txt", url, i), nil, 200, contentS3, 20, 30 * time.Second)
	}

}