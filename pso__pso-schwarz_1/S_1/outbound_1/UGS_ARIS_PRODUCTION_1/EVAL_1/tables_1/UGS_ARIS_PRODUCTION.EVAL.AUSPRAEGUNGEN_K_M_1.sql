CREATE OR REPLACE TABLE ugs_aris_production_eval.auspraegungen_k_m_1 (
sparte STRING(2) NOT NULL,
datenbank STRING(100) NOT NULL,
datum_export_mstr DATE,
modell_guid STRING(100),
objekt_guid STRING(100),
objekt_typ STRING(100),
anzahl_auspragungen_pro_symboltyp BIGNUMERIC(38,0),
symboltyp STRING(100),
dwh_valid_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP
);