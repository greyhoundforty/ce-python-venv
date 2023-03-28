import os
import logging
from logdna import LogDNAHandler
from datetime import datetime

# def logDnaLogger():
key = os.environ.get('LOGDNA_INGESTION_KEY')
log = logging.getLogger('logdna')
log.setLevel(logging.DEBUG)

options = {
    'env': 'dev',
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
    print("Testing Python virtualenv build works in CE at: " + deployTimestamp)
    print("Attempting to use LogDNA logger")
    log.warning("Testing warn message")
    log("Python Virtualenv test passed and this should show up under a Debug error column in the UI.")
except Exception as e:
    print("Python Virtualenv test failed. Error: " + str(e))