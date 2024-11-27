README
======

This Terraform code contains an approach to creating multiple AWS certificates ahead of time. 

A lot of where I played around was in `dyn_cert_validation` resource, which needed to have the `domain_validation_options` set from each domain. I worked around the issues by using `locals` and `flatten()` to produce a list of the `domain_validation_options` for each cert to be created.