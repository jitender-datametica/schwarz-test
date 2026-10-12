CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.shr_ma_funktion_gruppe_spr_zu_1 (
shr_ma_funktion_gruppe_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
shr_ma_funktion_gruppe_bez STRING(18) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);