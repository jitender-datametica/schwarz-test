CREATE OR REPLACE TABLE ugs_aris_production_etl_process.uebersetzungen_k_l_1 (
guid STRING(16777216),
attribut_guid STRING(16777216),
locale STRING(16777216),
name STRING(16777216),
value STRING(16777216),
dwh_valid_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP
) OPTIONS(description='DWH_LOAD_ID position change');