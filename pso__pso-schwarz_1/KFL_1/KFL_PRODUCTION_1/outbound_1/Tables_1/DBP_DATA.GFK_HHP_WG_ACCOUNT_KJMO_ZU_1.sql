CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_wg_account_kjmo_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gfk_account_id BIGNUMERIC(38,0) NOT NULL,
gfk_wg_id BIGNUMERIC(38,0) NOT NULL,
bewart_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(12) COLLATE 'und:ci',
umsatz_tsd_eur NUMERIC(18,4),
umsatz_potenzial_tsd_eur NUMERIC(18,4),
umsatz_potenzial_anteil BIGNUMERIC(38,5),
td_update TIMESTAMP,
td_insert TIMESTAMP
);