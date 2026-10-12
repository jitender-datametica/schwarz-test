CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_fin_gruppe_spr_zu_2 (
fin_gruppe_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
fin_kategorie_id STRING(20) COLLATE 'und:ci' NOT NULL,
fin_gruppe_bez STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);