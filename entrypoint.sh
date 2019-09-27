#!/bin/sh
adddate() {
    while IFS= read -r line; do
        printf '[%s] %s\n' "$(date +'%d:%m:%Y %H:%M:%S.%3N %:::z')" "$line";
    done
}

if [ -z $SLEEP_TIME ]
then
  >&2 echo "No Sleep time set! Using 300 Seconds"
  SLEEP_TIME="300"
fi

if [ "$TZ" == "Etc/UTC" ]
then
  >&2 echo "Timezone is set to UTC. You might want to set it via env TZ"
fi

echo "Going to sleep for $SLEEP_TIME seconds between checks" | adddate
sh ./check-dir.sh

while [ true ]
do
  echo "Fetching Mail..." | adddate
  getmail -v | adddate
  echo "Fetched Mail, sleeping" | adddate
  sleep "${SLEEP_TIME}s"
done
