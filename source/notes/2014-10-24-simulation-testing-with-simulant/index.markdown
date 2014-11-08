---
layout: page
title: "Talk Notes: Simulation Testing with Simulant"
date: 2014-10-24 11:00
comments: true
sharing: true
footer: true
tags:
- notes
---

# Summary

    Title: Simulation Testing with Simulant
    Conference: Online Webinar
    Speaker: Michael Nygard
    Date: 2014-10-24

<http://fast.wistia.net/embed/iframe/5vcu53dbnw>

# Notes

Classification

* Whitebox vs. Blackbox
* Automated vs. Manual, shifting toward the former

## New distiction: Example-Based vs Property-Based

### Example-Based

* known inputs and expected outputs
* Written by programmer
* Variety of scales (unit, functional, integration), mean different levels of fidelity (resolution)
* Using fixtures, stubs, mocks

Weaknesses

* Doesn't cover much of the state space.  100% code coverage doesn't cover all states.
* Fragile w.r.t. code changes, must be updated when the code is updated
    * doesn't indicate real breakage, but just change
* Poor scalability, longer and longer to run the tests
* Not composable, testing A and testing B doesn't mean C (which composes A and B) will work

### Property-Based

Logical statement that should be true about the system at all times.  A property.

Programmer models the domain and invariants and a program generates the tests.

```
(def sort-preserves-length
  (prop/for-all [v (gen/vector gen/int)]
    (let [s (sort v)]
      (= (count v) (count s)))))
```

gen/vector generates integers
gen/vector is a generator of generators

## Simulation testing

Property-Based, White box, Automated testing

* Extends property based testing to whole systems
* Modeling the domain, not the technical interactions
* Generate a **repeatable** script of inputs, so that next test run will confirm fixes
* Executions are saved
    * Can go back in time and add a new value and adding it to a previous execution and see if it fails
* Proving the system is wrong (keep outside of bad areas in state space), not proving that it is right (almost impossible)

* We want to find as many code paths as possible, but there is a limit on how long we can test, the curse of dimensionality.
* We want the greatest confidence for the time we test, so we want our trajectories through the code to be very diverse

System overview:

![](system_overview.png)

Each component is separated with an immutable database, typically datomic.

* Start with seting up the activity model, and adding initialization data.
* Event stream is consistent
* Runner runs the event stream through the system
* Output is stored in databases
* Validation comes from event stream, system database and outputs
    * Individual cases
    * Does the entire system conform to SLAs
    * Does the entire account total balance?
* Test report is generated from validations
    * Pass/Fail or a Grade

## Simulant

Open source framework for simulation testing

Pieces to fill in:

State transition model:

* what states are possible, with transitions and end states
* can have parameters on how frequently each state will happen or change
* Can be built by a "learning model" based on your existing traffic

![](model_example.png)

Generator:

* Generate event streams based on the transition model
* `causatum` used to generate
* need to create the set of actions when going between states
    * can be something that calls an API or drives a web page

Setting up the test:

* create database
* Create agents
* generate the actions for each agent
* Record it all in the database

Running the test:

* Executes activities
* records output
* record internal state, if needed
* Can use a clock multiplier, say 2 to run things twice as fast

Whole livecycle

![](lifecycle.png)

## Actions

repeatable, atomic, no validation (!!, record request and response for an api call, maybe deconstruct the result, but no checking), limited error checking

## Record

immutable record
stored for result of each action

## Validations

verify properties
these are queries
not erroring out, just reporting, transforming data from the tests into data about what happened
record new records

clojure tip: read from the bottom up

## test results

Tip: add in commit id of code and the commit id of tests

## test reports

summaries
visualization
history, trends, etc

## Advantages

* coverage
    * more state space exploration than scripted tests
* global validation
    * response time
    * money in == money out
* less expensive than hand-writing test

## Other considerations

Ran out of time before covering these:

* What kind of model suffices?
* Containing randomness in generator
* Making actions repeatable
* Target system setup
* test duration and intensity (and the problem of lag)

## Q&A

### Can Simulant be used to test race conditions?

Activity streams are run concurrently, will be run on a different threads.

Not like haskell quick-check that tries things in different order to scare out race conditions.

### How to test interaction between agents?  Generate scenarios where agents interact with each other?

Typically, no communication between agents.  Assume communication is happening, and abort if it doesn't.

Recommend a joint state model that models two agents interacting.

### Will the sample code be made available?

Yes, but it will be a while.  On github.

### If a database is the end state, how do you verify?

Simulant was built to test datomic itself, so you can pull from the database for validations.  If not datomic, capture a snapshot in the validation.

