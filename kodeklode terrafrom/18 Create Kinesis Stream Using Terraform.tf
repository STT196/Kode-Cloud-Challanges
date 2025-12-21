resource "aws_kinesis_stream" "nautilus_stream"{
    name             = "nautilus-stream"
    shard_count      = 1
    retention_period = 24
}