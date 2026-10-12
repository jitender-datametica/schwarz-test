CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_projekt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_projekt_id BIGNUMERIC(38,0) NOT NULL,
in_projekt_id_char STRING(30) COLLATE 'und:ci' NOT NULL,
in_projekt_bez STRING(40) COLLATE 'und:ci',
pc_id STRING(10) COLLATE 'und:ci',
krk_id STRING(4) COLLATE 'und:ci',
projekt_ext_id STRING(30) COLLATE 'und:ci',
in_budget_typ_id STRING(3) COLLATE 'und:ci',
rpm_projekt_typ_id STRING(20) COLLATE 'und:ci',
in_massnahme_typ_id STRING(3) COLLATE 'und:ci',
standort_id STRING(10) COLLATE 'und:ci' NOT NULL,
dat_massnahme_ende DATE,
ims_projekt_typ_id STRING(1) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);