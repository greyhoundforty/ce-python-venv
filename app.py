import os
import logging
from logdna import LogDNAHandler
from datetime import datetime

# def logDnaLogger():
key = os.environ.get('LOGDNA_INGESTION_KEY')
log = logging.getLogger('logdna')
log.setLevel(logging.INFO)

options = {
    'env': 'dev',
    'index_meta': True,
    'tags': 'ce-virtualenv',
    'url': 'https://logs.us-south.logging.cloud.ibm.com/logs/ingest',
    'log_error_response': True
}

logger = LogDNAHandler(key, options)

log.addHandler(logger)

    # return log

try:
    # log = logDnaLogger()
    deployTimestamp = datetime.now().strftime("%Y-%m-%d:%H:%M:%S")
    log.warn("Testing Python virtualenv build works in CE at: " + deployTimestamp)
except Exception as e:
    print("Python Virtualenv test failed. Error: " + str(e))