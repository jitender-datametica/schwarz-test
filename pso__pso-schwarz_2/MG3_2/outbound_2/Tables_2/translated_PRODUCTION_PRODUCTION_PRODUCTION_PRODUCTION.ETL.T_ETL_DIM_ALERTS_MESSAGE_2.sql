CREATE OR REPLACE TABLE production_production_etl.t_etl_dim_alerts_message_2 (
alerts_message_id INTEGER NOT NULL OPTIONS(description='The alarm message number for an alarm'),
alerts_location_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm location_2 on which the alarm occured and where the station is located at.'),
alerts_priority_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm priorities (also containing inactive components)'),
alerts_type_id INTEGER NOT NULL
OPTIONS(description='Unique identifier for the alarm type (0 = unknown 1 = system created alarm; 2 = manually created alarm)'),
alerts_message_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the alarm message in German'),
alerts_message_desc_de STRING(16777216) NOT NULL
OPTIONS(description='A textual description for the alarm message in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_message_id) NOT ENFORCED
);