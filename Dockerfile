FROM registry.access.redhat.com/ubi9/python-311

LABEL name="demosite" \
      version="latest"

RUN pip install django

COPY demosite/ /opt/demosite

WORKDIR /opt/demosite

EXPOSE 8080/tcp
ENTRYPOINT exec python /opt/demosite/manage.py runserver 0.0.0.0:8080
