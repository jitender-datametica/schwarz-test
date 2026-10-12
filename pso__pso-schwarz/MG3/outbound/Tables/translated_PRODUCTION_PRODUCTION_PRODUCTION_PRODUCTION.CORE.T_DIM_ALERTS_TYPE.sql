CREATE OR REPLACE TABLE production_production_core.t_dim_alerts_type (
alerts_type_id INTEGER NOT NULL
OPTIONS(description='Unique identifier for the alarm type (0 = unknown 1 = system created alarm; 2 = manually created alarm)'),
alerts_type_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the alarm type in German'),
alerts_type_desc_de STRING(16777216) NOT NULL OPTIONS(description='A textual description for the alarm type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_type_id) NOT ENFORCED
) OPTIONS(description='Dimension to describe, whether an alarm is system or manually generated.');