resource "aws_opensearch_domain" "nautilus_es"{
    domain_name = "devops-es"
    engine_version = "OpenSearch_1.3"

}