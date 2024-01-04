FROM python:3.8-slim

RUN apt-get update && \
    apt-get install -y libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip setuptools

WORKDIR /app

# Copy specific files into the container at /app
COPY app.py /app/
COPY requirements.txt /app/
COPY templates/ /app/templates/

# Install any needed packages specified in requirements.txt
RUN python -m pip install --no-cache-dir -r requirements.txt

# Run app.py when the container launches
CMD ["gunicorn", "--access-logfile", "-", "--error-logfile", "-", "-w", "4", "-b", "0.0.0.0:8080", "app:app"]
