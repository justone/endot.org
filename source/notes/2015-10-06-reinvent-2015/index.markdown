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

Announce QuickSight: cloud powered BI/viz

* Sputz: query runner
* Can share visualizations.
* 1/10th the cost of other solutions. 
* Supports all AWS data stores.
* Automatically selects best viz for data
* Pluggable backend for other data analysis tools 

### Freedom to get data into or out of the cloud easily

Streaming data. Kenesis requires custom code now.

Announce: Kenesis Firehose

Stream data into AWS
S3/Redshift to start
Compress or Encrypt

Large volumes of data. Import/Export currently.

Announce: Snowball

Shippable storage device.
Encrypted, tamper proof
50 TB to start. 

### Freedom from bad (database) relationships

Lock in with commercial, hard to scale open source

Aurora is their answer from last year.

Announce: MariaDB

Migration is hard too. Expensive tools, high risk.

Announce: Database Migration Service

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

Announce: AWS Config Rules

Rules on what must be in place
Eg enforce tagging rule.

Announce: Amazon Inspector

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

# Misc notes

## Interesting URLs

* <http://engineering.remind.com/introducing-empire/>
* <http://wiremock.org/>
