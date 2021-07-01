# To create sites.txt and other files
# These files need to be manually editted
# aws s3 ls s3://fcp-indi/data/Projects/ADHD200/RawDataBIDS/ --no-sign-request | tee sites.txt
# input2="./sites.txt"
# while IFS2= read -r var
# do
#   aws s3 ls s3://fcp-indi/data/Projects/ADHD200/RawDataBIDS/$var/ --no-sign-request | tee $var.txt
# done < "$input2"

input2="./sites.txt"
while IFS2= read -r var2
do
  mkdir ./dataset/$var2/
  aws s3 cp s3://fcp-indi/data/Projects/ADHD200/RawDataBIDS/$var2/participants.tsv ./dataset/$var2/ --no-sign-request
  aws s3 cp s3://fcp-indi/data/Projects/ADHD200/RawDataBIDS/$var2/T1w.json ./dataset/$var2/ --no-sign-request
done < "$input2"

input2="./sites.txt"
while IFS2= read -r var2
do
  echo $var2  
  input1="./$var2.txt"
  while IFS= read -r var
  do
    echo $var
    mkdir ./dataset/$var2/$var/
    mkdir ./dataset/$var2/$var/ses-1/
    mkdir ./dataset/$var2/$var/ses-1/anat/
    aws s3 cp s3://fcp-indi/data/Projects/ADHD200/RawDataBIDS/$var2/$var/ses-1/anat/ ./dataset/$var2/$var/ses-1/anat --no-sign-request --recursive
  done < "$input1"
done < "$input2"
