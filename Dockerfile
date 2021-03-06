FROM python:2.7
MAINTAINER James Quacinella <james.quacinella@gmail.com>

# Install dependencies
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y libxslt1-dev libxml2-dev
#                      libpq-dev expect libldap2-dev libsasl2-dev libssl-dev

# Install sentry for postgres and sentry slack integration
# RUN pip install -U sentry[postgres] sentry-slack
ADD requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

# Expose the sentry web port
EXPOSE 8080

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /wheels/*

