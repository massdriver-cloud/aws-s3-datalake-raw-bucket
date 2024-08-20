## AWS S3 Data Lake Raw Bucket

AWS S3 (Simple Storage Service) is a scalable, high-speed, low-cost web-based cloud storage service designed for online backup and archiving of data and application programs. This guide helps you manage S3 buckets specifically designed for a data lake's raw data.

### Design Decisions

- **Encryption**: Server-side encryption is enabled using AWS KMS keys to protect the data at rest.
- **Access Control**: Policies are created to provide fine-grained control over read/write access, ensuring both security and controlled access.
- **Lifecycle Policies**: Data is automatically moved to cheaper storage classes as it ages, optimizing costs.
- **Public Access Block**: Bucket-level settings are configured to block all public access, enhancing security.
- **Ownership Controls**: Object ownership is enforced to ensure all buckets and objects are owned by the bucket owner, simplifying permissions management.

### Runbook

#### Access Denied When Trying to Read or Write

Ensure that the IAM user/role has the correct policies attached.

Check the current policies attached to the user/role:

```sh
aws iam list-attached-user-policies --user-name <USERNAME>
aws iam list-attached-role-policies --role-name <ROLENAME>
```

You should see the policies created by this configuration.

#### Bucket Not Found or Access Denied

Ensure that the bucket exists and that you have sufficient permissions.

Check if the bucket exists:

```sh
aws s3 ls
```

Verify the bucket policy if you have access issues:

```sh
aws s3api get-bucket-policy --bucket <BUCKET_NAME>
```

#### Object Encryption Issues

If you encounter encryption errors when accessing objects, ensure that the KMS key is correctly configured and you have the `kms:Decrypt` permission.

Check KMS key ID associated with the bucket:

```sh
aws s3api get-bucket-encryption --bucket <BUCKET_NAME>
```

Ensure the IAM policy includes necessary KMS permissions:

```sh
aws iam get-policy --policy-arn <KMS_POLICY_ARN>
```

#### Data Retrieval Taking Too Long

Check the current storage class of the objects and ensure they are in the right class for frequent access.

List objects and their storage class:

```sh
aws s3api list-objects --bucket <BUCKET_NAME> --output text --query 'Contents[].[Key, StorageClass]'
```

#### Objects Deleted Accidentally

If the versioning is enabled, you can restore deleted objects.

List object versions:

```sh
aws s3api list-object-versions --bucket <BUCKET_NAME>
```

Restore a specific version of an object:

```sh
aws s3api get-object --bucket <BUCKET_NAME> --key <OBJECT_KEY> --version-id <VERSION_ID> <DOWNLOAD_PATH>
```

#### Troubleshooting Lifecycle Rules

Ensure lifecycle rules are applied correctly:

List lifecycle rules applied to the bucket:

```sh
aws s3api get-bucket-lifecycle-configuration --bucket <BUCKET_NAME>
```

Monitor logs for lifecycle transitions:

```sh
aws s3api list-object-versions --bucket <BUCKET_NAME>
```

#### Network Connectivity Issues

Check if S3 service is reachable:

```sh
ping s3.amazonaws.com
```

Confirm no network issues using traceroute:

```sh
traceroute s3.amazonaws.com
```

