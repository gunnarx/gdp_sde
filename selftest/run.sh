#!/bin/sh

/selftest/system_check.sh || echo "System-check failed"
/selftest/start_applications.sh

