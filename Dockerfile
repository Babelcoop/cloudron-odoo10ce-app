FROM cloudron/base:2.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea
MAINTAINER Samir Saidani <samir.saidani@babel.coop>

RUN mkdir -p /app/code /app/data
WORKDIR /app/code

COPY ./odoo10CE_install.sh /app/code/
COPY start.sh /app/code/

RUN /app/code/odoo10CE_install.sh
RUN wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
RUN echo "deb http://nightly.odoo.com/10.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
RUN apt-get update && rm -r /var/cache/apt /var/lib/apt/lists
RUN apt-get install patch

# patch to accept a database name 
COPY ./cloudron_odoo10ce.patch /app/code/
RUN patch -i /app/code/cloudron_odoo10ce.patch /app/code/odoo-server/odoo/sql_db.py

WORKDIR /app/data

CMD [ "/app/code/start.sh" ]
