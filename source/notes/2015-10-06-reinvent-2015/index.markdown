---
layout: page
title: "Notes: re:Invent 2015"
date: 2015-10-06 17:00
sharing: true
footer: true
tags:
- notes
---

# Links

* [Videos on Youtube](https://www.youtube.com/user/AmazonWebServices/videos) (organized into [playlists](https://www.youtube.com/user/AmazonWebServices/playlists))
* [Slides on SlideShare](http://www.slideshare.net/AmazonWebServices/tag/reinvent2015)

# Day 1 - Wednesday

## Keynote

[Video](https://www.youtube.com/watch?v=D5-ifl7KJ00)

### Freedom to innovate

Scalability, large suite of services

### Freedom to get insights from data

Storage, analysis.

Announce [QuickSight](https://aws.amazon.com/blogs/aws/amazon-quicksight-fast-easy-to-use-business-intelligence-for-big-data-at-110th-the-cost-of-traditional-solutions/): cloud powered BI/viz

* Sputz: query runner
* Can share visualizations.
* 1/10th the cost of other solutions.
* Supports all AWS data stores.
* Automatically selects best viz for data
* Pluggable backend for other data analysis tools

### Freedom to get data into or out of the cloud easily

Streaming data. Kenesis requires custom code now.

Announce: [Kenesis Firehose](https://aws.amazon.com/blogs/aws/amazon-kinesis-firehose-simple-highly-scalable-data-ingestion/)

Stream data into AWS
S3/Redshift to start
Compress or Encrypt

Large volumes of data. Import/Export currently.

Announce: [Snowball](https://aws.amazon.com/blogs/aws/aws-importexport-snowball-transfer-1-petabyte-per-week-using-amazon-owned-storage-appliances/)

Shippable storage device.
Encrypted, tamper proof
50 TB to start.

### Freedom from bad (database) relationships

Lock in with commercial, hard to scale open source

Aurora is their answer from last year.

Announce: [MariaDB](https://aws.amazon.com/blogs/aws/amazon-rds-update-mariadb-is-now-available/)

Migration is hard too. Expensive tools, high risk.

Announce: [Database Migration Service](https://aws.amazon.com/dms/)

- Synchronization
- Dashboard to see progress
- $3 for 1T

Moving from proprietary to open source

Announce: Schema Conversion Tool

- Free
- Avail today
- Converts functions too

Migration for applications is hard too

GE story

Accenture announce business group. To help people move into the cloud. Cloud Sherpas.

### Freedom to secure your cake and eat it too

VPC and WAF for now. Encryption, identity, compliance. AWS config.

Announce: [AWS Config Rules](https://aws.amazon.com/blogs/aws/aws-config-rules-dynamic-compliance-checking-for-cloud-resources/)

Rules on what must be in place
Eg enforce tagging rule.

Announce: [Amazon Inspector](https://aws.amazon.com/blogs/aws/amazon-inspector-automated-security-assessment-service/)

Detect and remediate security issues.
Assessments and tracking.

Stripe story

### Freedom to say yes

Yes to projects

MLB
NHL too.

## DVO317 - From Local Docker Development to Production Deployments

[Video](https://www.youtube.com/watch?v=7CZFpHUPqXw)

Speaker: Jérôme Petazzoni

Desc: In this session, we will learn how to define and run multi-container applications with Docker Compose. Then, we will show how to deploy and scale them seamlessly to a cluster with Docker Swarm; and how Amazon EC2 Container Service (ECS) eliminates the need to install,operate, and scale your own cluster management infrastructure. We will also walk through some best practice patterns used by customers for running their microservices platforms or batch jobs. Sample code and Compose templates will be provided on GitHub afterwards.

Code for sample application: <https://github.com/jpetazzo/dockercoins> [sample url](http://reinvent.dckr.info:8000/index.html) (only worked during presentation)

Interesting command `docker-compose build` - rebuild images

* Docker machine can create EC2 instances
* Docker swarm to wrap them into a cluster

ECS CLI:

* create cluster with aws best practices
* coming soon from AWS

Scripts used in presentation: <https://github.com/jpetazzo/orchestration-workshop>

dev docker compose yaml file -> production compose file:

* build each image
* tag with unique number
* push to registry
* replace `build` with `image`

Service discovery - connect with ambassadors

Examples for ambassadors: [Simple training wheels application](https://github.com/jpetazzo/trainingwheels)

ECS CLI will take compose file and convert to task file!

- only image definitions, no build
- has to fix up yaml indenting

[jpetazzo/hamba](https://github.com/jpetazzo/hamba) - load balancing ambassador container

Network ambassadors, sharing the network namespace

main difference between using ecs-cli and swarm is that the former scales up the whole stack at a time and the latter allows scaling individual services

Ambassador can also:

- inject credentials
- be a smarter proxy
- use another AWS service where appropriate (elasticache, rds)

# Day 2 - Thursday

## Keynote

[Video](https://www.youtube.com/watch?v=uiDwqgXj5Q8)

AWS well-architected framework. White paper.
Four areas, dozen questions each area.

Six laws every architect should know.

### Lucas Critique

Analyzing data.

Announce: Kenesis Analytics ([sign up page](https://aws.amazon.com/kinesis/analytics/))

* Time series analysis of streaming data. Avail next year.
* Can leverage s3

### Galls Law

Simple system -> complex system, never was complex from start.

VMs; Containers, and then Lambda is the simplest.

First VMs:

Announce: [X1 instance type](https://aws.amazon.com/blogs/aws/ec2-instance-update-x1-sap-hana-t2-nano-websites/)

* 2TB of RAM
* 100 cores
* Avail 1H 2016

Smaller? Announce: T2 nano

512 M
Avail later this year

Now Containers:

PaaS, batch processing

* Remind story
* Micro services powered by containers.
* Kicked off Empire, thin layer on top of ecs

Simpler management.

Announce: container registry

* Fully managed, secure
* Avail later this year, sign up today

Announce: AZ aware scheduler

Announce: ecs cli, integration with compose

[blog post](https://aws.amazon.com/blogs/aws/ec2-container-service-update-container-registry-ecs-cli-az-aware-scheduling-and-more/)

Announce: [Cloudwatch dashboards](https://aws.amazon.com/blogs/aws/cloudwatch-dashboards-create-use-customized-metrics-views/)

Now Lambda:

"No server is easier to manage than no server" -- W.Vog

Lots of integrations already, API, mobile, SNS

Announce: ([blog post](https://aws.amazon.com/blogs/aws/aws-lambda-update-python-vpc-increased-function-duration-scheduling-and-more/))

* VPC support
* Long running functions
* Scheduled functions
* Custom Retry logic
* Python for Lambda

### Law of Demeter

Limited knowledge

Lots of mobile applications now, gaming, productivity, banking.

Announce: [Mobile Hub](https://aws.amazon.com/blogs/aws/aws-mobile-hub-build-test-and-monitor-mobile-applications/)

1. Choose and configure, pick components, guides you through the process
2. Download the source, iOS and android
3. Build?

### Occam's Razor

Fewest assumptions.

* IoT
* Massive data (genome) into S3
* Science streaming into the cloud.
* Commercial IoT

BMW story, cars are more connected, more sensors

### Reed's Law

Utility of network increases with size

IoT greenhouse in expo hall

Announce: [AWS IoT](https://aws.amazon.com/blogs/aws/aws-iot-cloud-services-for-connected-devices/)

* Helping build IoT apps
* Connecting devices to the cloud
* Mqtt protocol
* Security with x509
* Data collection/analysis in AWS, trigger lambda
* Avail in beta today

* Adding device gateway to collect mqtt protocol
* Paired with rules engine to route and query
* Registry to store data about your devices and query

How do you communicate to the device? Device Shadow. A proxy for the device that will handle retry, etc.

SDK for C, JS, and arduino.

John Deere story

### The Gestalt Principle

Whole greater than sum of parts

Intel story

## DAT407 - Amazon ElastiCache: Deep Dive

[Video](https://www.youtube.com/watch?v=4VfIINg9DYI)

Speaker: Nate Wiger (AWS), Tom Kerr (Riot)

Desc: Peek behind the scenes to learn about Amazon ElastiCache's design and architecture. See common design patterns of our Memcached and Redis offerings and how customers have used them for in-memory operations and achieved improved latency and throughput for applications. During this session, we review best practices, design patterns, and anti-patterns related to Amazon ElastiCache.

Big difference between Memcached and Redis

Memcached:

* Multithreaded
* No persistence
* Flat cache, k/v
* Low maintenance, easy to scale horizontally

Redis:

* Single threaded
* Persistence
* Advanced data types
* Advanced features: rtomic counters, messaging
* replicas, failover

### ElastiCache with Memcached

For development, use a one node cluster
For production, spread across AZs
For extreme low latency, create cluster per AZ

When adding nodes:

* traffic is spread across all nodes
* it's like flushing part of your cache.  gradually add nodes instead of all at once

Sharding:

* Consistent hashing maps to node, use a library for it (and make sure that it's enabled)
* Libraries can autoconfigure with config endpoint
* Also could put a proxy in between servers and ElastiCache (twemproxy or mcrouter)
    * Convenient for not impacting live code config
    * Good for big pool or change a lot
    * Additional layer of latency

App Caching Patterns:

* Lazy cache, query db on cache miss
* Write through cache, write to cache when updating it
* TTLs should be set on all cache keys
    * Short TTL for front page top stories (just enough to relieve pressure)
    * Long TTL for infrequently changing data

### ElastiCache with Redis

Use cases:

* Real time leaderboard, built on sorted sets, Redis keeps a ranked list of entries
* counters and hashes for likes and rankings
* Chat (pub/sub) or server to server communication

Deployment is basically identical in development.

In production:

* Multi AZ is supported
* Async replication to read replicas (chance for data loss)
    * Snapshots for back up can be done from read replicas
* Automatically failover, like RDS (1-2 minutes of downtime)
* For read-heavy applications, can add more nodes

Splitting Redis by Purpose

* Key caveat: You can't partition your data, so can only scale vertically
* Solve this by splitting (sharding) by purpose (e.g. counters and leaderboards)

Soon, Lambda will be able access ElastiCache because of VPC support

### Performance Tuning

Monitor with Cloudwatch:

* CPUUtilization (up to 90%)
    * For redis, number is divided by cores (90% / 4 = 22.5%)
* SwapUsage - make sure it's zero
* Evictions - make sure it's low
    * Exception: russian doll caching (popularized by Rails 4) - always cache w/o timeouts and let the cache engine handle expiration
* CacheMisses / CacheHits Ration - low
* CurrConnections - should be stable
* MOre detail in whitepaper: bit.ly/elasticache-whitepaper

Scaling it up: Snapshot, spin up new cluster from snapshot

Specific issues:

* Thundering herd
    * Slowly bring up new nodes
    * Randomize TTLs
* Redis Failover
    * Watch out for dns cache (and
    * Can use promote button to test application flexibility
* Redis backups
    * Forks main redis to write out memory
    * Potentially doubles memory usage, if high throughput app
    * Set 'reserved-memory' as off limits to redis

Enhancments only on ElastiCache

* Forkless backups
* More robust replication under heavy loads
* Optimized replica resync on failover, to make failover less awful
* Two new cloudwatch metrics

### Use case by Riot Games

Very player focused company.  He works on the comment infrastructure and leaderboards

Apollo

* JS drop in to any page, basically like Disqus
* On boards as well
* Backed with ElastiCache, Redis as main data store
* To compensate for failure
    * Configure replication across availability zones
    * Automatic failover
    * Lots of snapshots

Deployment

* Packer to build images
* CLI scripts and Jenkins to automate

Leaderboards

* Millions of requests to redis
* Backend is ElastiCache
* They do memory optimization (see docs)

## CMP406 - Amazon ECS at Coursera: Powering a general-purpose near-line execution microservice, while defending against untrusted code

[Video](https://www.youtube.com/watch?v=a45J6xAGUvA)

Speaker: Brennan Saeta (Coursera), Frank Chen (Coursera)

Desc: Coursera has helped millions of students learn computer science through MOOCs ranging from Introduction to Python, to state-of-the-art Functional-Reactive Programming in Scala. Our interactive educational experience relies upon an automated grading platform for programming assignments. But, because anyone can sign up for a course on Coursera for free, our systems must defend against arbitrary code execution.

Come learn how Coursera uses AWS services such as Amazon EC2 Container Service (ECS), and Amazon Virtual Private Cloud (VPC) to power a defense-in-depth strategy to secure our infrastructure against bad actors. We have modified the Amazon ECS Agent to support security layers including kernel privilege de-escalation, and enabling mandatory access control systems. Additionally, we post-process uploaded grading container images to defang binaries.

At the core of automated grading is a general-purpose near-line & batch scheduling and execution microservice built on top of the Amazon ECS APIs. We use this flexible system to power a variety of internal services across the company including data exports for instructors, course announcement emails, data reconciliation jobs, and more.

In this session, we detail aspects of our success from implementing Docker and Amazon ECS in production, providing ideas for your own scheduling, execution and hardening requirements.

### Intro to Coursera

Online learning, 1300 courses, 2.5 Mil participants

### Nearline batch execution framework

Batch processing: Reporting, instructors and internal

Scheduled processing:

Nearline processing: Peer review matching (human grading), grading programming assignments

Started off with two systems:

* Cascade - PHP based job runner
    * Polling for new jobs
    * Fragile and unreliable
* Saturn - Scala based backend
    * Based on quartz
    * Same JVM made for contention

Desired solution:

* Reliable
* Easy development
* Easy deployment
* High efficiency - start job in 15 seconds, important for nearline
* Low ops load - only one devops engineer
* Cost effective

Tried:

* Home-grown - unreliable, difficult to coord and sync
* Mesos - need expertise, hard to productize
* Kubernetes - need expertise, not managed

Found ECS was the right fit, but needed a little more on top

Built Iguazu - batch job scheduler

* API on front
* Storage in cassandra
* Uses SQS to notify backend
* Initially used ECS scheduler, moved to their own
    * prevent running on terminating instances
    * prevent termination when jobs are running

They wrote a Scala API for scheduling jobs

Deployment is done via Jenkins

* Creates a new image
* Uploads to registry
* Updates ECS

Use SumoLogic for log analysis, wrap job name and job id at start of log lines for easy searching

Use DataDog for metrics

### Evaluating programming assignments

Docker container contains analysis and test code.

Security challenge: running untested code from students

First solution:

Individuals would test code in a separate AWS account, custom grader systems, or local desktops

* No autoscaling
* Non-standard security
* Instability

Desired a shared platform for

* cost savings
* no maintenance
* near real time
* unified security model

See slides for Threat Model

created GrID - Grading Inside Docker

* upload assignment to S3
* Scheduled job on Iguazu

Possible attacks:

* Resource exhaustion
    * mem/cpu/swap
    * Hard cgroup limits are set
    * timeout for container execution
    * btrfs limits (quota and iops throttling)
* Kernel resource exhaustion
    * open files, process limits
    * Limit kernel memory per cgroup to prevent too many forks
    * execution time limit
* Network attacks
    * Bitcoin miner, DoS against other systems, access AWS apis to gain information
    * Solution is to deny network access
        * Had to modify ECS agent to allow specify network modes (he says that as of this morning, that is true)
        * Disabling networking is too much (some exersizes require localhost networking)
        * Switched to --net=none + deny net_admin + audit network

Protections against container engine vulnerabilities:

* They use apparmor because they're on ubuntu
* Required another modification of ECS agent, no longer needed
* Drop capabilities
* No root in containers
    * Pull apart uploaded images
    * Clear setuid off all binaries
    * C wrapper to do additional checks
* Their system for modifying images required another ECS agent modification to allow specifying `--privileged`
* Regularly terminate ASG instances in case someone escaped

* CloudTrail for audit logs
* Third party monitoring by ThreatStack
* Synack for pen testing

Grading is communicated via a shared filesystem, to a python co-process

Lessons learned:

* Latest kernels
* btrfs - Ubuntu 14.04 is not new enough
* Monitor disk usage carefully
* Deployment tooling is absolutely necessary

## CMP301 - AWS Lambda and the Serverless Cloud

Speaker: Tim Wagner

Desc: With AWS Lambda you can easily build scalable microservices for mobile, web, and IoT applications or respond to events from other AWS services without managing infrastructure. In this session you’ll see demonstrations and hear more about newly launched features, as well as a recap of the languages, tools, and features added over the last several months. We’ll show you how to use Lambda to build mobile backends, create web, IoT, and voice-enabled apps, and extend both AWS and third party services by triggering Lambda functions – all without the need for servers or other infrastructure. We’ll also provide productivity and performance tips for getting the most out of your Lambda functions and show how cloud native architectures use Lambda to eliminate “cold servers” and excess capacity without sacrificing scalability or responsiveness.

Overview of Lambda, why you would use it

Use Lambda for processing incoming email in SES

Now can use Lambda to process logs from CloudWatch Logs

Python 2.7, available today, includes boto3

Longer running functions: up to 5 minutes

Scheduled jobs for checking external services (could use to check websites)

New feature: versioning

* Specified by number
* Instead of "upload", you use "publish" to make an immutable copy
    * automatically makes a version numbered version (1, 2, 3, etc.)
    * also can create aliases

IoT rules can call Lambda functions

New feature: VPC Access

* allows access to resources that are protected inside a VPC (RDS, ElastiCache, EC2)
* VpcConfig config section in function definition
    * includes subnet and security group ids

<http://aws.amazon.com/blogs/compute>

# Day 3 - Friday

## STG406 - Using S3 to Build and Scale an Unlimited Storage Service for Millions of Consumers

[Video](https://www.youtube.com/watch?v=WRJhdhGzJVg)

Speakers: Tarlochan Cheema (AWS), Kevin Christen (AWS)

Desc: Amazon Cloud Drive's plans to provide a low cost, unlimited storage service presented a major engineering challenge. In this session, you learn how the Amazon Cloud Drive team designed and optimized the storage back-end, Amazon S3, to handle millions of users while containing infrastructure costs. In this session, the lead engineers share details of how they built the service for massive scale, and the regular steps they take to increase performance and efficiency. They also describe proven techniques for scaling and optimization, learned from experience.

### What is Cloud Drive? - unlimited cloud storage for consumers

* No free tier
* Unlimited photos, 5G of space for other (free for Prime)
* Unlimited everything

For developers:

* APIs
* Mobile SDKs
* Revenue sharing

### Key challenges

* Number of users
* Number of files
* Velocity of content
* Metadata variety
* indexing and querying
* Logs

### Design goals

Typical for large scale data storage:

scalable, durable, reliable, low latency, RESTful, low cost, etc.

### Architecture

* Main processing on EC2
* S3 for content storage
* DynamoDB for metadata
* Transcoder, CloudSearch, SNS
* Kinesis for feeding analysis systems

### Use of S3

* Content (main and derived)
    * Standard storage
    * Randomly generated keys (keeps load even across partitions)
    * Server side encryption
* Log files
    * 800 servers running (peaking to 1000)
    * 200G of logs an hour
    * Archived by Timber log service
    * Encrypts and stores in S3
    * Types
        * Application - time and severity stamped
        * Service logs, per invocation - standard format across Amazon, source for metrics
        * Wire logs
        * No access logs
    * Analysis = Instances -> S3 -> EMR -> S3 -> RedShift
* Dynamic configuration (across the fleet)
    * Heavy use of feature toggles (enable for test customers, % of customers, or on for everyone)
    * Config files stored in S3
    * Poll with GetObjectMetadata and reload file if ETag has changed
* DynamoDB backups
* They use the standard Java SDK

### Challenges and design decision

* 1: Upload size variation
    * Text files to VM images
    * Solution is size aware
        * < 15M is just uploaded
        * Use multipart upload to S3 for large files, using a threadpool
* 2: Rapid upload availability
    * Some content require processing
    * Solution: use sync, async and optimistic sync processing
        * Example: images - sync extract of exif
        * Example: video - async transcoding to other formats
        * Example: Document transformation to PDF - optimistic sync, or try sync with a timeout
* 3: Intermiettent connections
    * Uploads used to be in a single connection, not good for mobile devices
    * Solution: ability to resume an upload
        * Use HTTP Content-Range header
        * Problem: Upload to S3 must be done with a single instance's credentials
            * Switched to STS solution, could have done pre-signed urls
            * Blog post: http://amzn.to/1FLeoii
* 4: Download size variation
    * Solution: size aware logic
        * < 5M - simple get object, sync; covers 90% of files
        * larger - parallel download logic using Apache HTTPClient, range requests
* 5: Thumbnails of large images
    * Most generated on the fly, at request time
    * Large files are harder
    * Solution: Another bucket as an infinite cache
        * Save medium size to second bucket with expiration of 48 hours
        * Create smaller size to serve
        * Subsequent accesses use second bucket's copy
        * Use metadata from request to generate key so you don't have to hit the DB
* 6: Large direct downloads
    * Downloading usually is done via the service as intermediary
    * Large files with no transformations are hard
    * Solution: Use an S3 presigned url

### Takeaways

* S3 is flexible
* Selecting keys is important
* Upload and Download strategies should vary based on file size
* Network is unreliable. Retry, but only up to a limit.

## DAT304 - Amazon RDS for MySQL: Best Practices

[Video](https://www.youtube.com/watch?v=eHg8LD5KNC0)

Speaker: Abdul Sait (AWS), Kevin Rice (AirBnB)

Desc: Learn how to monitor your database performance closely and troubleshoot database issues quickly using a variety of features provided by Amazon RDS and MySQL including database events, logs, and engine-specific features. You will also learn about the security best practices to use with Amazon RDS for MySQL as well as how to effectively move data between Amazon RDS and on-premises instances. Hear from Amazon RDS customer Airbnb about the best practices they have implemented in their RDS for MySQL architectures.

New in RDS

* Max size to 6T
* Simplified Reserved instances
* Encryption at rest, HIPAA compliance
* Migration Service

Strategies:

* Create cross region snapshots
    * Can keep a warm standby for DR
    * Base for migration or testing data
* Encryption at rest
    * KMS, etc.
* Database migration with minimal downtime
    * Migration Service
    * Cross version or cross engine
    * Expressed as a task that can be reused in production
* Conversion Tool
* Design for cost
    * GP2 storage - SSD, earn credits like T2
        * get a larger storage, even when you don't need it
    * Burst capacity

From Airbnb

* Doubling number of engineers every year
* RDS stores most important data
* sync_binlog=0 for performance reasons, would like it to be 1
* Snapshots for data analytics, point in time restore to extract and then destroyed
* System called Spinal Tap
    * Binlog streaming
    * Server watches the binlog and invalidates cache
* DR - extreme scenario
    * Back up with mysqldump to S3, pulled into a different account
* Future work
    * Cross region read replicas
    * horizontal sharding
    * Partitioning
    * Aurora

## SEC314-R - NEW LAUNCH! AWS Config/Config Rules: Use AWS Config Rules to Improve Governance over Configuration Changes to Your Resources (Repeat Session)

[Video](https://www.youtube.com/watch?v=96K-cpttpYc)

Speaker: Prashant Prahlad (AWS)

Desc: AWS Config enables you to discover what resources are used on AWS, understand how resources are configured and gives you unprecedented visibility into changes to configurations over time – all without disrupting end user productivity. With Config Rules, you can continuously evaluate whether changes to resources are compliant with policies. You can set up predefined rules, provided and managed by AWS, or author your own rules using Amazon Lambda, and these rules are evaluated whenever relevant resources are modified. You can use this visibility and control to assess and improve your security and compliance posture.

We will dive deep into other new capabilities in AWS Config and cover how you can integrate with IT service management, configuration management, and other tools. In this session, we will look at:

AWS Config Rules – how to create and use rules that govern configuration changes recorded by AWS Config.
New capabilities in AWS Config – Usability changes, better controls and other enhancements
Mechanisms to aggregate deep visibility across AWS to gain insights into your overall security and operational posture.
This session is best suited for administrators, security-ops and developers with a focus on audit, security and compliance.

Visibility is foundational for security

* Either there is no visibility, just hope
* Or a CMDB

In the cloud, visibility is even more important because of the power of software

Options:

* Poll Describe APIs
* Maintain infra to store results
* Lots of duplicate data
* Normalize formats

AWS Config is just that:

* Inventory of existing resources
* Discovery of new resources
* Record changes continuously
* Notify when changes happen
* Historical data as well

Rules

* Preconfigured
* Custom rules via Lambda
* Invoked continuously
* Dashboard for visualizing compliance

Getting started with Rules:

* Open Config
* Select type of resources to record
* Create S3 bucket to deliver data to
* Create SNS topic to send notifications
* Grant access

Multi region patterns:

* SNS topic in each region
* SQS in target region
* Common bucket in target region

Key Concepts:

Configuration Item - a point in time representation of the configuration of the resource

* Metadata - information about the configuration
* Common Attributes - resource id, tags, type, arn
* Relationships - how it is connected
* Current Configuration - information specific to the resource
* Related Events - cloudtrail event id

Dashboard allows searching for resources and viewing each configuration item

What can we do with Config Rules?

* Managed rules - prebuilt rules, managed by AWS
    * 7 to start, eg EBS volumes must be encrypted, EIPs must be attached, SGs should have no open ports, CloudTrail to be enabled.
* Customer managed rules - self maintained rules, run in Lambda in your account
    * Can use partner created rules too
    * Can specify parameters, show up in rule creation
    * Creation
        * Create Lambda function
        * Grant permissions to function (to write to Config)
        * Configure the custom rule in Config

Triggered in two ways:

* Changes, scoped to a tag or resource type or resource id
    * Evaluation is the result of applying a rule against a resource
* Time

Use Cases:

* Security analysis
* Audit compliance
* Change management
    * Can pipe changes into existing CMDB or use as a datasource for CMDBs
* Troubleshooting
* Discovery

Adding rules are simple, can see result of applying rules and drill into resources.  Can also see what rules apply to which resources.

Everything is available via CLI and API as well.

Coverage:

* EC2
* EBS
* VPC
* CloudTrail
* IAM support now

Growing ecosystem

Pricing: Only when recording configuration item ($0.003/CI)

Config Rule: $2.00 per rule per month, with 20K evaluations per active rule (shared among all rules, like family plan). $0.0001 per evaluation after that.

# Misc notes

## Other talks to watch

* ARC340 - Multi-tenant Application Deployment Models ([Video](https://www.youtube.com/watch?v=DMP0leGZpo4))
* DAT401 - Amazon DynamoDB Deep Dive: Schema Design, Indexing, JSON, Search, and More ([Video](https://www.youtube.com/watch?v=ggDIat_FZtA))
* DVO205 - Monitoring Evolution: From Flying Blind to Flying by Instrument ([Video](https://www.youtube.com/watch?v=d3xYujJ1qx8))
* MBL302 - Building Scalable, Serverless Mobile and Internet of Things Back Ends ([Video](https://www.youtube.com/watch?v=GnaO-LwdSuU))
* BDT209 - NEW LAUNCH! Amazon Elasticsearch Service for Real-time Data Analytics and Visualization ([Video](https://www.youtube.com/watch?v=s7dJESec_dY))

* DVO209 - JAWS: The Monstrously Scalable Serverless Framework – AWS Lambda, Amazon API Gateway, and More! ([Video](https://www.youtube.com/watch?v=D_U6luQ6I90))
* GAM401 - Build a Serverless Mobile Game with Amazon Cognito, Lambda, and DynamoDB ([Video](https://www.youtube.com/watch?v=JT2xOYOdUvM))
* STG403 - Amazon EBS: Designing for Performance ([Video](https://www.youtube.com/watch?v=2wKgha8CZ_w))
* DVO202 - DevOps at Amazon: A Look at Our Tools and Processes

* ARC310 - Amazon.com: Solving Amazon's Catalog Contention and Cost with Amazon Kinesis ([Video](https://www.youtube.com/watch?v=9MZtBMjOFsQ))
* CMP401 - Elastic Load Balancing Deep Dive and Best Practices ([Video](https://www.youtube.com/watch?v=91TAx4fmcxk))
* GAM402 - Turbine: A Microservice Approach to Three Billion Game Requests a Day ([Video](https://www.youtube.com/watch?v=txJmBA4cdQM))
* DEV310 - CI/CD of Services with Mocking and Resiliency Testing Using AWS ([Video](https://www.youtube.com/watch?v=sUsh3EnzKKk))

* CMP307 - Using Spot Instances for Production Workloads
* SEC304 - Architecting for HIPAA Compliance on AWS ([Video](https://www.youtube.com/watch?v=g4XI4IIYVrw))
* STG401 - Amazon S3 Deep Dive and Best Practices ([Video](https://www.youtube.com/watch?v=1TvJCLl9NNg))
* BDT318 - Netflix Keystone: How Netflix Handles Data Streams Up to 8 Million Events Per Second ([Video](https://www.youtube.com/watch?v=Kc-7eIfaK04))

* DVO308 - Docker & ECS in Production: How We Migrated Our Infrastructure from Heroku to AWS ([Video](https://www.youtube.com/watch?v=8zbbQkszP04))
* DVO304 - AWS CloudFormation Best Practices ([Video](https://www.youtube.com/watch?v=fVMlxJJNmyA))

* SEC318 - AWS CloudTrail Deep Dive ([Video](https://www.youtube.com/watch?v=t0e-mz_I2OU))
* BDT307 - Zero Infrastructure, Real-Time Data Collection, and Analytics ([Video](https://www.youtube.com/watch?v=ygHGPnAd0Uo))

* CMP302 - Amazon EC2 Container Service: Distributed Applications at Scale ([Video](https://www.youtube.com/watch?v=eun8CqGqdk8))
* LT119 - Python, Go, and the Cost of Concurrency in the Cloud

* ARC309 - From Monolithic to Microservices: Evolving Architecture Patterns in the Cloud ([Video](https://www.youtube.com/watch?v=C4c0pkY4NgQ))
* SEC401 - Encryption Key Storage with AWS KMS at Okta ([Video](https://www.youtube.com/watch?v=pi4HTSrmzis))

* DEV301 - Automating AWS with the AWS CLI ([Video](https://www.youtube.com/watch?v=TnfqJYPjD9I))
* SPOT203 - Fourth Annual Startup Launches, Hosted by Werner Vogels
* CMP403 - AWS Lambda: Simplifying Big Data Workloads ([Video](https://www.youtube.com/watch?v=WWDHxy4zuqg))j
* ARC301 - Scaling Up to Your First 10 Million Users ([Video](https://www.youtube.com/watch?v=vg5onp8TU6Q))

* DVO313 - Building Next-Generation Applications with Amazon ECS ([Video](https://www.youtube.com/watch?v=xIc3WT6kAVw))

## Interesting URLs

* <http://engineering.remind.com/introducing-empire/>
* <http://wiremock.org/>
* <https://github.com/aws/aws-sdk-go/wiki/Getting-Started-Common-Examples>
* <https://github.com/awslabs/aws-go-wordfreq-sample>
* <https://github.com/spotify/luigi>
