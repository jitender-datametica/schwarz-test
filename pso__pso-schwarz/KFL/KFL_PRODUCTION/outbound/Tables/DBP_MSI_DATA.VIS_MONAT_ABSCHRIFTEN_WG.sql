CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_abschriften_wg (
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL,
abt_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
abschrift_brutto NUMERIC(18,2) NOT NULL,
abschrift_brutto_kum NUMERIC(18,2) NOT NULL,
abschrift_brutto_kvj NUMERIC(18,2) NOT NULL,
abschrift_brutto_kvj_kum NUMERIC(18,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id;