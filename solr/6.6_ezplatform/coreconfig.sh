#!/bin/bash

# copies default config files from solr distrib + updates solrconfig according to eZPlatform requirements

SolrCoreDir="server/solr/ezplatform"
cd /opt/solr
mkdir -p $SolrCoreDir/{template,conf}
cp server/solr/configsets/basic_configs/conf/{currency.xml,solrconfig.xml,stopwords.txt,synonyms.txt,elevate.xml} $SolrCoreDir/conf/
cp server/solr/solr.xml $SolrCoreDir/
sed -i.bak '/<updateRequestProcessorChain name="add-unknown-fields-to-the-schema">/,/<\/updateRequestProcessorChain>/d' $SolrCoreDir/conf/solrconfig.xml
sed -i.bak 's/\${solr.autoSoftCommit.maxTime:-1}/\${solr.autoSoftCommit.maxTime:20}/' $SolrCoreDir/conf/solrconfig.xml
