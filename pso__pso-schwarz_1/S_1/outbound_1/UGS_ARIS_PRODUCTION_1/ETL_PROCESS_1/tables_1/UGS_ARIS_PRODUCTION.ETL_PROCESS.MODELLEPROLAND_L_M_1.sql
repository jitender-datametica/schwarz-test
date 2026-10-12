CREATE OR REPLACE TABLE ugs_aris_production_etl_process.modelleproland_l_m_1 (
sparte STRING(16777216),
datenbank STRING(16777216),
datum_export_mstr DATE,
land_id STRING(16777216),
prozess_id STRING(16777216),
prozess_der_ebene STRING(16777216),
pfad STRING(16777216),
modell_guid STRING(16777216),
dwh_valid_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP
) OPTIONS(description='DWH_LOAD_ID position change');