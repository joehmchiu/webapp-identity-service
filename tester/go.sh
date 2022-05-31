
temp=temp-tf
[ -d $temp ] && rm -rf $temp
cp -rf tf $temp
cd $temp
terraform init
terraform apply -auto-approve

cd ../ansible
ansible-playbook -i hosts playbook.yml
