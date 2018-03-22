from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import requests

if __name__ =="__main__":
    # input.json should just be in place already, if it has been given.
    # Using environ.get to be a little more robust against missing values.

    with open("envvar_value.json", "w") as f:
        json = os.environ.get("INPUT_JSON")
        if json:
            f.write(json)

    with open("envvar_url.json", "w") as f:
        url = os.environ.get("INPUT_JSON_URL")
        if url:
            f.write(requests.get(url).text)

    print('envvars read')

    HTTPServer(('', 80), SimpleHTTPRequestHandler).serve_forever()

    print('server started')