CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.marktabschriften_coi_dat_1 (
wup_id BIGNUMERIC(38,0),
nb_id BIGNUMERIC(38,0),
dat DATE,
mandant_id BIGNUMERIC(38,0),
abschriftart_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
abschriftbetrag_netto NUMERIC(18,2),
abschriftbetrag_netto_vj NUMERIC(18,2),
wrg_id STRING(12) COLLATE 'und:ci',
wup_bereinigt_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, dat;