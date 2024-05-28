# MDB Tools REST GET API

Install 'mdbtools' in the Docker image that will host the 'REST' service. This can be done by adding 'RUN apt-get install -y mdbtools' to the 'Dockerfile'.
Write Python code that implements the REST API endpoints to expose the 'mdbtools' functionality. For example:
'GET /tables?database=<path>': List the tables in the specified 'Access database' file
'GET /export?database=<path>&table=<name>': Export the data from the specified table to the response

You can use the subprocess module to call the mdbtools CLI commands and return the output as the API response.
