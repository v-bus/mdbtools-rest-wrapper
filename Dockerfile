FROM python:3.9-slim

# Install mdbtools
RUN apt-get update && apt-get install -y mdbtools

# Set the working directory
WORKDIR /app

# Copy the Python code
COPY mdbtools_rest.py .

# Install Python dependencies
RUN pip install flask pandas

# Expose the port
EXPOSE 5000

# Set the entry point
CMD ["python", "mdbtools_rest.py"]
