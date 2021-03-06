# Schema Validation

This repository stores a project to perform automated contract tests using Ruby, Ajv, Draft schemas;

### Installation and usage

##### Download Ruby (Stable Version):

[Ruby Version Manager (RVM)](https://rvm.io/)

##### Download Bundler (manage ruby gems):
    
    gem install bundler

##### Clone the project:
    
    git clone https://github.com/murilopmachado/chamatheapp_assignment.git

##### Download dependencies:
In terminal at the project root:
    
    bundle install

##### In terminal at the project root:

    rspec spec/osrm_spec.rb 

Every run creates an HTML report using TimeStamp in the name and making sure that we can track the results later.

## Questions

#### Question 1
##### Write two integration tests for OSRM's HTTP API using a testing framework of your choice.

For this question, I've tried to have the maximum coverage possible in two scenarios. I've created a class with a constructor to perform the requests if needed to make the creation of new scenarios easier and faster.

Scenarios:

- Execute valid routing requests with success using valid coordinates
- Execute invalid routing requests with failure using invalid coordinates.

Both scenarios check the response json schema to assure that our key and values are OK. 
The schema's in data/schemas/, and it's fair easy to update.

#### Question 2
##### Describe how the tests you have written could be integrated into a fully automated CI/CD pipeline.

Independent on the CI/CD tool that we're using, we can create a job that'll be triggered after the build process and configure the pipeline to only create the Release Candidate(CI) or Deploy the Release Candidate(CD) if all jobs run successfully. 

Bellow one example of a pipeline containing the tests:

* Prepare the environment with everything needed for the application run;
   * Download and configure the dependencies required for the project inside an AWS EC2 or Azure Virtual Machine;
     * [Docker](https://www.docker.com/)
     * [Docker OSRM Container](https://hub.docker.com/r/osrm/osrm-backend/)    
* Start the container with an accessible extern port:
     * [See OSRM Container documentation](https://hub.docker.com/r/osrm/osrm-backend/)
* Prepare the environment but that time with the focus on the tests;
   * Download and configure the dependencies needed for the automation;
     * [Ruby](https://rvm.io/)
     * [Gems](https://bundler.io/) 
   * Pull the automation code;
* Execute the automation;

The point is split into two jobs (One to configure the environment and another to run the container) It's in that way we'll have more concise errors with that making it easier to troubleshoot later if needed.

Depending on the tool (Jenkins, Circle, Bamboo, Travis) could change the way to configure the environment.
