CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wug_2 (
wug_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Warenuntergruppe');