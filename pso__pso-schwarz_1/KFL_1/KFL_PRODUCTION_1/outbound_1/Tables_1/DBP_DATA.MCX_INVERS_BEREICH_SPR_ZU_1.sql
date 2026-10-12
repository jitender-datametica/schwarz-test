CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mcx_invers_bereich_spr_zu_1 (
invers_ber_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
invers_ber_bez STRING(150) COLLATE 'und:ci',
invers_ber_bez_2 STRING(150) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);