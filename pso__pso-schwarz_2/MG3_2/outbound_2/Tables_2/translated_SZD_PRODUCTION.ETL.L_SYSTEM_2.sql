CREATE OR REPLACE TABLE szd_production_etl.l_system_2 (
system_id INTEGER NOT NULL,
system_bez STRING(20) COLLATE 'und:ci' NOT NULL,
kl_system_bez STRING(10) COLLATE 'und:ci' NOT NULL,
kl_system_id STRING(2) COLLATE 'und:ci' NOT NULL,
mandant_id INTEGER NOT NULL,
system_rolle STRING(1) COLLATE 'und:ci' NOT NULL,
system_gruppe STRING(20) COLLATE 'und:ci' NOT NULL
);