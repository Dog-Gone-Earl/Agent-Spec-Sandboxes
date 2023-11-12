#!/opt/datadog-agent/embedded/bin/python

import json
import sys

secrets={"mysql_username": {"value": "datadog", "error": None}, "mysql_password": {"value": "<$PASSWORD>", "error": None}}
sys.stdout.write(json.dumps(secrets))
