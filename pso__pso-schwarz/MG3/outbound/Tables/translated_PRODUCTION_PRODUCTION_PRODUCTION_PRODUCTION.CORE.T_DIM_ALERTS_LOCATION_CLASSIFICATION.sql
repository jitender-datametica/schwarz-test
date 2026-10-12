CREATE OR REPLACE TABLE production_production_core.t_dim_alerts_location_classification (
alerts_location_classification_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm location classification on which the alarm occured and where the station is located at.'),
alerts_location_classification_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the alarm location classification in German'),
alerts_location_classification_desc_de STRING(16777216) NOT NULL
OPTIONS(description='A textual description for the alarm location classification in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_location_classification_id) NOT ENFORCED
) OPTIONS(description='Table to classify alarm locations within the BonGelati.');