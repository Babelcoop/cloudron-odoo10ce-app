FROM cloudron/base:2.2.0@sha256:ba1d566164a67c266782545ea9809dc611c4152e27686fd14060332dd88263ea
MAINTAINER Samir Saidani <samir.saidani@babel.coop>

RUN mkdir -p /app/code /app/data
WORKDIR /app/code

COPY ./odoo10CE_install.sh /app/code/
COPY start.sh /app/code/

# Run the custom Odoo installation script
RUN /app/code/odoo10CE_install.sh

# Add Odoo repository GPG key
RUN wget -O - https://nightly.odoo.com/odoo.key | apt-key add -

# Create and add the Odoo repository to sources.list.d
RUN echo "deb http://nightly.odoo.com/10.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list

# Add a step to fetch the GPG key for MongoDB or other needed repositories if they exist
# Example for MongoDB (if required):
RUN curl -fsSL https://pgp.mongodb.com/server-4.4.asc | gpg --dearmor -o /usr/share/keyrings/mongodb-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# Update package lists and clean up
RUN apt-get update 
RUN apt-get install -y patch 
RUN rm -rf /var/lib/apt/lists/*

# Apply the patch to accep database name to Odoo
COPY ./cloudron_odoo10ce.patch /app/code/
RUN patch -i /app/code/cloudron_odoo10ce.patch /app/code/odoo-server/odoo/sql_db.py

WORKDIR /app/data

CMD [ "/app/code/start.sh" ]
