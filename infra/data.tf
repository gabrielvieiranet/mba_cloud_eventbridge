data "archive_file" "lambda_zip" {
  count       = length(local.lambdas)
  type        = "zip"
  source_dir  = "${local.base_dir}/${local.lambdas[count.index]}"
  output_path = "${local.lambdas[count.index]}.zip"
}
