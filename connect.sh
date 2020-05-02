#!/bin/bash

. .env

echo "connecting to localhost:${KODIPORT}"
xfreerdp /u:kodiuser /p:${KODIUSERPWD} /f /rfx /sound /cert-ignore /v:localhost:${KODIPORT}
