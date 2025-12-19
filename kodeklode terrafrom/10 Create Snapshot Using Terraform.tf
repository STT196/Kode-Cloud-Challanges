resource "aws_ebs_volume" "k8s_volume" {
  availability_zone = "us-east-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name = "datacenter-vol"
  }
}

resource "aws_ebs_snapshot" "datacenter-vol-ss" {
  volume_id   = aws_ebs_volume.k8s_volume.id
  description = "Datacenter Snapshot"
  tags = {
    Name = "datacenter-vol-ss"
  }

}

resource "null_resource" "wait_for_snapshot" {
  depends_on = [aws_ebs_snapshot.datacenter-vol-ss]

  provisioner "local-exec" {
    command = <<EOT
        echo "Waiting for snapshot ${aws_ebs_snapshot.datacenter-vol-ss.id} to complete..."
        aws ec2 wait snapshot-completed --snapshot-ids ${aws_ebs_snapshot.datacenter-vol-ss.id} --region us-east-1
        echo "Snapshot ${aws_ebs_snapshot.datacenter-vol-ss.id} is now completed."
        EOT
        interpreter = ["bash", "-c"]
  }
}

output "snapshot_id" {
  value = aws_ebs_snapshot.datacenter-vol-ss.id
}   

output "snapshot_status" {
  depends_on = [null_resource.wait_for_snapshot]
  value      = "completed"
}
