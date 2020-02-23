#### Question 1
##### Write two integration tests for OSRM's HTTP API using a testing framework of your choice.

For this question, I've tried to have the maximum coverage possible in two scenarios.
I've created a class with a constructor to perform the requests if needed in the future efficiently. That'll make the creation of new scenarios easier and faster.

* The first scenario uses a schema to check the response.
* The second one tries to request with invalid parameters.


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

The point in split in two jobs (One to configure the environment and another to run the container) It's in that way we'll have more concise errors with that making it easier to troubleshoot later if needed.

Depending the tool (Jenkins, Circle, Bamboo, Travis) could change the way used to configure the environment.

To create the schema, I've used json-schema-generator gem. In the future, if needed, we can create a hook or a job that'll always generate a new schema, that way making sure that we have the most updated json_schema version.
