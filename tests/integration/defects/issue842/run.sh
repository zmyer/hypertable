#!/usr/bin/env bash

HT_HOME=${INSTALL_DIR:-"/opt/hypertable/current"}
SCRIPT_DIR=`dirname $0`

echo "======================="
echo "Defect #842"
echo "======================="

cp ${SCRIPT_DIR}/data.tsv .

# only start servers if they're not yet running
$HT_HOME/bin/serverup rangeserver
if [ "$?" -ne "0" ]
then
    $HT_HOME/bin/start-test-servers.sh --clear
fi

$HT_HOME/bin/ht hypertable < ${SCRIPT_DIR}/create-table.hql
$HT_HOME/bin/ht hypertable --namespace / --exec "LOAD DATA INFILE 'data.tsv' INTO TABLE metrics;"

$HT_HOME/bin/ht hypertable --namespace / \
    --no-prompt --test-mode \
    --exec "USE '/'; SELECT metric:'2012-05-14 00' FROM metrics WHERE ROW = 'monitor-prod-4.proxy-a-1.haproxy-api.api.api-504.v2-checkins-add.http_200';" \
    > test.output
$HT_HOME/bin/ht hypertable --namespace / \
    --no-prompt --test-mode \
    --exec 'USE "/"; SELECT metric:"2012-05-14 00" FROM metrics WHERE ROW = "monitor-prod-4.proxy-a-1.haproxy-api.api.api-504.v2-checkins-add.http_200";' \
    >> test.output

diff test.output $SCRIPT_DIR/test.golden
if [ $? -ne 0 ]
then
  echo "output differs"
  exit -1
fi

echo "SUCCESS"
