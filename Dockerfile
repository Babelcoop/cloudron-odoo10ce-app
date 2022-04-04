FROM cloudron/base:0.12.0
MAINTAINER Samir Saidani <samir.saidani@babel.coop>

RUN mkdir -p /app/code /app/data
WORKDIR /app/code

COPY ./odoo10CE_install.sh /app/code/

RUN /app/code/odoo10CE_install.sh
RUN wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
RUN echo "deb http://nightly.odoo.com/10.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
RUN apt-get update && rm -r /var/cache/apt /var/lib/apt/lists

# patch to accept a db name
COPY sql_db.py /app/code/odoo-server/odoo/sql_db.py
# COPY sql_db.py /app/code/

COPY start.sh /app/data/

CMD [ "/app/data/start.sh" ]
