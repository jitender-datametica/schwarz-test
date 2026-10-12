CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_fin_kategorie_spr_zu (
fin_kategorie_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
fin_kategorie_bez STRING(80) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);