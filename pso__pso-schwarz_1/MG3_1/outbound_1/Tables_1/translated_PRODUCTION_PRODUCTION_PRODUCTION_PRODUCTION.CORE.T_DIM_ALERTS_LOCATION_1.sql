CREATE OR REPLACE TABLE production_production_core.t_dim_alerts_location_1 (
alerts_location_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm location_1 on which the alarm occured and where the station is located at.'),
alerts_location_classification_id INTEGER NOT NULL
OPTIONS(description='The unique identifier for the alarm location_1 classification on which the alarm occured and where the station is located at.'),
alerts_location_parent_id INTEGER OPTIONS(description='The parent ID (location_1) for a station alert.'),
alerts_location_hierarchy_level_id INTEGER
OPTIONS(description='The hierarchy_1 level of a location_1 id. 1= location_1, 2 = station'),
alerts_location_desc STRING(16777216) NOT NULL
OPTIONS(description='A textual default description for the alarm location_1 in German'),
alerts_location_desc_de STRING(16777216) NOT NULL
OPTIONS(description='A textual description for the alarm location_1 in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (alerts_location_id) NOT ENFORCED
) OPTIONS(description='Hierarchy_1 for the alert locations and stations within the Bon Gelati.');