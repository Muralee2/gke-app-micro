#gcloud projects create modern-girder-463514-t1
##gcloud config set project modern-girder-463514-t1
#gcloud services enable container.googleapis.com compute.googleapis.com dns.googleapis.com

gcloud iam service-accounts create terraform --display-name "Terraform Service Account"
gcloud projects add-iam-policy-binding modern-girder-463514-t1 --member="serviceAccount:terraform@modern-girder-463514-t1.iam.gserviceaccount.com" --role="roles/editor"
gcloud iam service-accounts keys create key.json --iam-account=terraform@modern-girder-463514-t1.iam.gserviceaccount.com