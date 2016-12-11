"""
w3validate.py:

Supply an URL and it returns the amount if the document passed the validation
test.

Makes use of the w3.org API

Licensed under MIT by Zarthus <zarthus@zarth.us>
Date: 03/06/2014
"""

import requests


def w3_validate_url(website):
    val_link = "http://validator.w3.org/check?uri=" + website

    r = requests.get(val_link)
    valid = r.headers["x-w3c-validator-status"].lower()

    if valid == "valid":
        return "The website {} is {}.".format(website, valid)
    if valid == "abort":
        # Possibility that the URL is invalid
        return ("The validation for '{}' aborted unexpectedly."
                " Is this a valid URL?".format(website))

    errors = r.headers["x-w3c-validator-errors"]
    warnings = r.headers["x-w3c-validator-warnings"]
    recursion = r.headers["x-w3c-validator-recursion"]

    errstring = ""
    if errors:
        errstring += "Errors: {}, ".format(errors)
    if warnings:
        errstring += "Warnings: {}, ".format(warnings)
    if recursion:
        errstring += "Recursion: {}, ".format(recursion)
    if errstring:
        # Remove the ", " from the string.
        errstring = errstring[:-2]
        return "The website {} is {}. {}".format(website, valid, errstring)

    return "The website {} is {}.".format(website, valid)