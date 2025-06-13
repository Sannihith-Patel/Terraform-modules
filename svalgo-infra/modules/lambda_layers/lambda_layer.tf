resource "aws_lambda_layer_version" "AXIOS_LAYER" {
  filename                 = "${path.module}/lambda_layers/AXIOS_LAYER.zip"
  layer_name               = "AXIOS_LAYER"
  compatible_architectures = ["x86_64"]
  compatible_runtimes      = ["nodejs18.x"]
}