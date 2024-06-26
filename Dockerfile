FROM nvidia/cuda:11.0-base

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Install Whisper dependencies
RUN pip3 install whisper

# Copy your Whisper application code
COPY . /app
WORKDIR /app

# Run the application
CMD ["python3", "whisper_app.py"]
