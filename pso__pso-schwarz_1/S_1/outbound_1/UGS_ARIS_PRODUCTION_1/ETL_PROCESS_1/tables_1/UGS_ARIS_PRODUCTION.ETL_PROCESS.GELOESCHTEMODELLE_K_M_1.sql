CREATE OR REPLACE TABLE ugs_aris_production_etl_process.geloeschtemodelle_k_m_1 (
sparte STRING(2) NOT NULL,
datenbank STRING(100) NOT NULL,
datum_export_mstr DATE,
modell_guid STRING(100),
dwh_valid_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP
) OPTIONS(description='DWH_LOAD_ID position change');