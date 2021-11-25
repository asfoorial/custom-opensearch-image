OPENSEARCH_HOME=`dirname $(realpath $0)`; cd $OPENSEARCH_HOME
exec $OPENSEARCH_HOME/bin/opensearch "$@"