FROM registry.redhat.io/rhel8/python-36

LABEL name="demosite" \
      version="0.2"

RUN pip install django

COPY demosite/ /opt/demosite

WORKDIR /opt/demosite

EXPOSE 8080/tcp
ENTRYPOINT exec python /opt/demosite/manage.py runserver 0.0.0.0:8080
