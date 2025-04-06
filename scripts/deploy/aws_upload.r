library(aws.s3)

Sys.setenv("AWS_ACCESS_KEY_ID" = "your-access-key",
           "AWS_SECRET_ACCESS_KEY" = "your-secret-key",
           "AWS_DEFAULT_REGION" = "us-east-1")

upload_to_s3 <- function(file_path, bucket_name, object_key) {
  put_object(file = file_path, object = object_key, bucket = bucket_name)
}

upload_to_s3("reports/sales_report.html", "your-s3-bucket", "reports/sales_report.html")
upload_to_s3("data/processed/summary_data.csv", "your-s3-bucket", "data/summary_data.csv")
