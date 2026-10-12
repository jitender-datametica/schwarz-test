CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_ums_ek_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
einkaufsorganisation_id BIGNUMERIC(38,0),
kj_bezugsjahr BIGNUMERIC(38,0),
teilgebiet STRING(10) COLLATE 'und:ci',
umsatz_netto NUMERIC(12,2),
umsatz_wrg_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);