terraform {
 backend "s3" {
    bucket = "ivan-backend-bucket"
    key = "backend/zavrsni_rad.tfstate"
    region = "eu-central-1"
    dynamodb_table = "remote-backend"
 } 
}
