#!/bin/bash

SERVICE_KEY=$(circleci env subst "${KEY_ENV}")
if [[ -z "$SERVICE_KEY" ]]; then
  echo "Need to set parameters.service-key non-empty"
  exit 1
fi

echo "$SERVICE_KEY" | base64 --decode | sudo twingate setup --headless=-
sudo twingate start

# collect logs
sudo journalctl -u twingate --no-pager | tail -n 20