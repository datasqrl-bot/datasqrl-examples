CREATE TABLE CustomerReward (
     PRIMARY KEY (`customerId`) NOT ENFORCED
) WITH (
      'connector' = 'kafka',
      'properties.bootstrap.servers' = '${PROPERTIES_BOOTSTRAP_SERVERS}',
      'properties.group.id' = 'mygroupid',
      'scan.startup.mode' = 'group-offsets',
      'properties.auto.offset.reset' = 'earliest',
      'key.format' = 'raw',
      'key.fields' = 'customerId',
      'value.format' = 'flexible-json',
      'topic' = 'customerreward'
      );