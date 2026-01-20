# Use official Python S2I base image
FROM registry.redhat.io/rhscl/python-39-rhel8:latest

# Switch to root to install dependencies
USER root

# Update pip, setuptools, wheel to latest compatible versions
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install any OS-level dependencies your app needs (e.g., gcc, libffi, etc.)
RUN dnf install -y gcc libffi-devel bzip2 bzip2-devel \
    && dnf clean all

# Switch back to non-root user (OpenShift runs as random UID)
USER 1001

# Copy application code
COPY . /opt/app-root/src/

# Install Python dependencies
RUN pip install --no-cache-dir -r /opt/app-root/src/requirements.txt

# Set default working directory
WORKDIR /opt/app-root/src/

# Run the app
CMD ["python3", "app.py"]
