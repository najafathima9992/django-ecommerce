FROM registry.access.redhat.com/ubi9/python-311

USER root

RUN dnf install -y \
    gcc \
    gcc-c++ \
    make \
    libjpeg-turbo-devel \
    zlib-devel \
    freetype-devel \
    && dnf clean all

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip setuptools<70 wheel
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
