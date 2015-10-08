---
layout: page
title: "Notes: re:Invent 2015"
date: 2015-10-06 17:00
sharing: true
footer: true
tags:
- notes
---

# Day 1 - Wednesday

## Keynote

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

# Misc notes

## Interesting URLs

* <http://engineering.remind.com/introducing-empire/>
* <http://wiremock.org/>
