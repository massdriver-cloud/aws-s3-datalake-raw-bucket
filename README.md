[![Massdriver][logo]][website]

# aws-s3-datalake-raw-bucket

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

AWS S3 raw datalake bucket!

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/cis_aws>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/pci>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/nist>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/iso>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/soc2>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-s3-datalake-raw-bucket/hipaa>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-s3-datalake-raw-bucket&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`bucket`** *(object)*
  - **`lifecycle`** *(object)*
    - **`transfer_s3_glacier`** *(integer)*: Minimum: `1`. Maximum: `365`. Default: `60`.
    - **`transfer_s3_ia`** *(integer)*: Minimum: `1`. Maximum: `365`. Default: `30`.
  - **`region`** *(string)*: AWS Region to provision in.

    Examples:
    ```json
    "us-west-2"
    ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`bucket`** *(object)*: Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

    - **`security`** *(object)*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
      - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
        - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
          - **`policy_arn`** *(string)*: AWS IAM policy ARN.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

      - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
        - **`role_arn`** *(string)*: ARN for this resources IAM Role.

          Examples:
          ```json
          "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
          ```

          ```json
          "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
          ```

      - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
        - **`^[a-z-]+$`** *(object)*
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
          - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/issues>) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]


<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud?utm_source=aws-s3-datalake-raw-bucket&utm_medium=aws-s3-datalake-raw-bucket&utm_campaign=aws-s3-datalake-raw-bucket&utm_content=aws-s3-datalake-raw-bucket
[website]: https://www.massdriver.cloud?utm_source=aws-s3-datalake-raw-bucket&utm_medium=aws-s3-datalake-raw-bucket&utm_campaign=aws-s3-datalake-raw-bucket&utm_content=aws-s3-datalake-raw-bucket
[github]: https://github.com/massdriver-cloud
[linkedin]: https://www.linkedin.com/company/massdriver/

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[contributors_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/graphs/contributors>
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[forks_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/network/members>
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[stars_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/stargazers>
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[issues_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/issues>
[release_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/releases/latest>
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-s3-datalake-raw-bucket.svg?style=for-the-badge>
[license_url]: https://github.com/massdriver-cloud/aws-s3-datalake-raw-bucket/blob/main/LICENSE>

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
