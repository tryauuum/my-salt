#!/usr/bin/python3

import sys
import time
import json
import base64
from subprocess import Popen, PIPE

TIME_ALLOWED_TO_WAIT = 1

vds_id = sys.argv[1]
cmd = sys.argv[2]
quemu_cmd = "virsh qemu-agent-command" + " " + vds_id
queme_param = {
    "execute": "guest-exec",
    "arguments": {
        "path": "bash",
        "arg": ["-c", cmd],
        "capture-output": True,
    },
}

print(queme_param, file=sys.stderr)

cmd = quemu_cmd + " '" + json.dumps(queme_param) + "'"
process = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
stdout, stderr = process.communicate()
stdout, stderr = stdout.strip(), stderr.strip()

print(stdout.decode("utf-8"), stderr.decode("utf-8"), file=sys.stderr)

queme_param["execute"] = "guest-exec-status"
queme_param["arguments"].pop("path")
queme_param["arguments"].pop("arg")
queme_param["arguments"].pop("capture-output")
queme_param["arguments"]["pid"] = json.loads(stdout.decode("utf-8"))["return"]["pid"]

cmd = quemu_cmd + " '" + json.dumps(queme_param) + "'"
start_time = time.time()
while time.time() - start_time < TIME_ALLOWED_TO_WAIT:
    try:
        process = Popen(cmd, stdout=PIPE, stderr=PIPE, shell=True)
        stdout, stderr = process.communicate()
        print(
            base64.b64decode(json.loads(stdout.decode("utf-8"))["return"]["out-data"])
            .decode("utf-8")
            .strip()
        )
        sys.exit(0)
    except KeyError:
        time.sleep(0.1)
sys.exit(1)
