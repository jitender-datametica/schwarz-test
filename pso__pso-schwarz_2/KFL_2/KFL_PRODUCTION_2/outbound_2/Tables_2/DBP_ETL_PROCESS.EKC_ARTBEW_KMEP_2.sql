CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ekc_artbew_kmep_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
zeitraum_kz STRING(2) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE,
betrag_kmep NUMERIC(18,4),
menge_artbew_sum NUMERIC(18,3),
betrag_kmep_einh NUMERIC(18,4),
td_insert TIMESTAMP,
td_update TIMESTAMP,
wrg_id STRING(3),
betrag_kmep_einh_o_fwu BIGNUMERIC(38,4)
);