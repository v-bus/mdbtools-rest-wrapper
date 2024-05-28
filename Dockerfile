FROM python:3.9-slim as core

# Install mdbtools
RUN apt-get update && apt-get install -y mdbtools

FROM core as app

# Install Python dependencies
RUN pip install flask pandas

FROM app as run
# Set the working directory
WORKDIR /app
# Copy the Python code
COPY mdbtools_rest.py .



# Expose the port
EXPOSE 5000

# Set the entry point
CMD ["python", "mdbtools_rest.py"]
