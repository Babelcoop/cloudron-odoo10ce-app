# Odoo CE Version 10 - Cloudron Application

This repository contains version 10 of Odoo Community Edition (CE) packaged as a Cloudron application. To use this application, developers need to build the Cloudron package using the instructions provided below.

## Building the Cloudron Package

To build the Odoo CE Cloudron package, follow these steps:

1. Ensure you have all the necessary prerequisites for building Cloudron packages.

2. Follow the instructions in the Cloudron packaging tutorial: [Cloudron Packaging Tutorial](https://docs.cloudron.io/packaging/tutorial/).

## Additional Documentation

For more information on using Odoo CE or Cloudron-specific configuration, refer to the official documentation:

- Odoo CE Documentation: [Odoo Documentation](https://www.odoo.com/documentation/12.0)
- Cloudron Documentation: [Cloudron Documentation](https://docs.cloudron.io/)

## Known Issues

- This version of Odoo does not work on Cloudron versions 7.4 and above. 
- The problem comes from the cloudron updated postgresql package. The PostgreSQL authentication mechanism fails, likely due to the use of the deprecated Python2 OpenSSL library.


## Reporting Issues

If you encounter any issues during the building or installation process or have any questions, please report them by opening an issue in the Issues section of this GitHub repository.
