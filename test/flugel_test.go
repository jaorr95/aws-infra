package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strconv"
	"testing"
)

func TestFlugel(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../flugel",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	validateBucket(t, terraformOptions)
	
}

func validateBucket(t *testing.T, opts *terraform.Options) {

	bucketName := terraform.Output(t, opts, "defined_bucket_name")
	expectedCcontentS3 := terraform.Output(t, opts, "content_files_s3")
	filesQuantity, _ := strconv.Atoi(terraform.Output(t, opts, "object_files_quantity"))
	aws.AssertS3BucketExists(t, "us-west-2", bucketName)

	for i := 1; i <= filesQuantity; i++ {
		fileContent := aws.GetS3ObjectContents(t, "us-west-2", bucketName, fmt.Sprintf("file%d.txt", i))
		assert.Equal(t, expectedCcontentS3, fileContent)
	}

}
