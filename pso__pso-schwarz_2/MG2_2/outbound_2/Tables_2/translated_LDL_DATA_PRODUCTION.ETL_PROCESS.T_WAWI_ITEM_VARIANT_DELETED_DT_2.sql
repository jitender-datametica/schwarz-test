CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_wawi_item_variant_deleted_dt_2 (
wawi_item_variant_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the Wawi item.'),
ctrcode STRING(2) NOT NULL OPTIONS(description='Wawi country_2 code. Canary islands (CS) is converted to Spain (ES).'),
orig_item_nr INTEGER NOT NULL
OPTIONS(description='Wawi short item_2 number, sourced from LDL_DATA_PRODUCTION.ARTIKEL.ARTNRVIER.'),
src_case_size INTEGER NOT NULL OPTIONS(description='Wawi case size'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the first appearance of the Wawi item_2, sourced from LDL_DATA_PRODUCTION.ARTIKEL.GUELTIG_AB.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Closure timestamp, set when a new Wawi item_2 with matching number is defined.'),
deleted_dt DATE
OPTIONS(description='Date of deletion of the WAWI item_2, according to T920_DELITEMS. Null if the Wawi item_2 is still existing in Wawi.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')
);