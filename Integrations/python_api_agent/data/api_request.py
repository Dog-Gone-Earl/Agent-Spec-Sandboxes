import requests

from datadog_api_client import ApiClient, Configuration
from datadog_api_client.v2.api.logs_api import LogsApi
from datadog_api_client.v2.model.http_log import HTTPLog
from datadog_api_client.v2.model.http_log_item import HTTPLogItem

r = requests.get('https://reqres.in/api/users/2')
print(r.text)
json_data = r.json()
#print(json_data['data']['first_name'])

"""
Send logs returns "Request accepted for processing (always 202 empty JSON)." response
"""
body = HTTPLog(
    [
        HTTPLogItem(
r.text
        ),
    ]
)

configuration = Configuration()
with ApiClient(configuration) as api_client:
    api_instance = LogsApi(api_client)
    response = api_instance.submit_log(body=body)

    print(response)
    
