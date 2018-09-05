#!/bin/bash -eux

aws s3 cp ./ s3://ocp-quickstart/quickstart-redhat-openshift --recursive --exclude ".git/*" --exclude "./tmp/*"

aws cloudformation deploy \
  --template-file ./templates/openshift.template \
  --s3-bucket ocp-quickstart \
  --s3-prefix deploy \
  --capabilities CAPABILITY_IAM \
  --stack-name ${1} \
  --parameter-overrides \
      KeyPairName= \
      PrivateSubnet1ID= \
      PrivateSubnet2ID= \
      PrivateSubnet3ID= \
      PublicSubnet1ID= \
      PublicSubnet2ID= \
      PublicSubnet3ID= \
      QSS3BucketName=ocp-quickstart \
      RemoteAccessCIDR=10.0.0.0/8 \
      ContainerAccessCIDR=10.0.0.0/8 \
      VPCID= \
      VPCCIDR=10.104.220.0/22 \
      OpenShiftAdminPassword=${OPENSHIFT_ADMIN_PASSWORD} \
      RedhatSubscriptionUserName= \
      RedhatSubscriptionPoolID= \
      RedhatSubscriptionPassword=${REDHAT_SUBSCRIPTION_PASSWORD} \
      OpenshiftContainerPlatformVersion=3.10 \
      MasterInstanceType=t2.large \
      EtcdInstanceType=t2.large \
      NodesInstanceType=t2.large \
      NumberOfNodes=1 \
      ClusterName=${1} \
      DomainName= \
      AWSServiceBroker=Disabled \
      HawkularMetrics=Disabled
