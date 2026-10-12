CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.marktabschriften_wg_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
abschriftart_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
abschriftbetrag_netto NUMERIC(18,2) NOT NULL,
abschriftbetrag_brutto NUMERIC(18,2) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);