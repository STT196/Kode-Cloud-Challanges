# Generate RSA private key
resource "tls_private_key" "devops-key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

# Create AWS key pair using generated public key
resource "aws_key_pair" "devops-key" {
    key_name   = "nautilus-kp"
    public_key = tls_private_key.devops-key.public_key_openssh
}

# Save private key to local file
resource "local_file" "private-key" {
    content  = tls_private_key.devops-key.private_key_pem
    filename = "/home/bob/nautilus-kp.pem"
    file_permission = "0600"
}
