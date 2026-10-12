CREATE OR REPLACE TABLE ugs_aris_production_eval.hinterlegungen_k_l_1 (
sparte STRING(2) NOT NULL,
datenbank STRING(100) NOT NULL,
object_guid STRING(100),
hinterlegte_modell_guid STRING(100),
dwh_valid_fg BOOL,
dwh_load_id BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP
);