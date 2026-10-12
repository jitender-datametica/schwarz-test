CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kostenrechnung_1 (
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL,
pc_id STRING(10) COLLATE 'und:ci' NOT NULL,
plan_fg BIGNUMERIC(38,0) NOT NULL,
planvariante_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id_ker STRING(6) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
kostenrechnung_betrag NUMERIC(18,2),
kj_ker_mo_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);