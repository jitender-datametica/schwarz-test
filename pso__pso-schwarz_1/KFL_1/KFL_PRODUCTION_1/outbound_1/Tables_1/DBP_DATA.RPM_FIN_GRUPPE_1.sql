CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_fin_gruppe_1 (
fin_gruppe_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
fin_kat_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL,
fin_gruppe_id STRING(20) COLLATE 'und:ci' NOT NULL,
fin_kategorie_id STRING(20) COLLATE 'und:ci' NOT NULL,
fin_gruppe_version_id STRING(10) COLLATE 'und:ci',
fin_gruppe_version_dat DATE,
td_update TIMESTAMP,
td_insert TIMESTAMP
);