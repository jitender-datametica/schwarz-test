CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_fin_kategorie (
fin_kat_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
fin_kategorie_id STRING(20) COLLATE 'und:ci' NOT NULL,
rpm_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
fin_kat_version_id STRING(10) COLLATE 'und:ci',
fin_kat_version_dat DATE,
td_insert TIMESTAMP,
td_update TIMESTAMP
);