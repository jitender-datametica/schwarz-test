CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_real_estate_event_1 (
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the event occurred.'),
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
real_estate_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for real estate objects. It distinguishes between store buildings, warehouse buildings and other kinds of real estate objects.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the business country_1 to which the real estate object belongs. (The business country_1 is not identical to a political country.)'),
reporting_country_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the reporting country_1 to which the real estate object belongs.'),
real_estate_event_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of event which changes the status_1 of a real estate object, such as opening, closing or relocation.'),
real_estate_event_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason why the status_1 of a real estate object has changed. E.g. a store was closed because of lack of expansion options.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (bus_dt, real_estate_sid, real_estate_event_type_cd) NOT ENFORCED
)
OPTIONS(description='This transactional fact tracks the events which change the status_1 of real estate objects, such as stores. This includes openings, closings or relocations. The type of event is defined by the real estate event type code.');