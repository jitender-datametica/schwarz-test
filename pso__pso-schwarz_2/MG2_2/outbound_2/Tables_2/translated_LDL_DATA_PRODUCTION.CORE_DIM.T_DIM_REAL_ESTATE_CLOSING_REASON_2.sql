CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_real_estate_closing_reason_2 (
closing_reason_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the reason, why a real estate object has been (permanently) closed.'),
closing_reason_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the reason, why a real estate object has been (permanently) closed. (Description in group language, i.e. in German) (Description in group language, i.e. in German)'),
closing_reason_descr_de STRING(250)
OPTIONS(description='A textual description for the reason, why a real estate object has been (permanently) closed. (Description in group language, i.e. in German) (Description in German)'),
closing_reason_descr_en STRING(250)
OPTIONS(description='A textual description for the reason, why a real estate object has been (permanently) closed. (Description in group language, i.e. in German) (Description in English)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (closing_reason_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the reasons why a real estate object has been (permanently) closed.\n             the lifecycle status_2 for real estate objects.. E.g. an object may be under contract, open, closed or terminated. (This is the business lifecycle, so it might differ from the status_2 code shown in the source system.)');