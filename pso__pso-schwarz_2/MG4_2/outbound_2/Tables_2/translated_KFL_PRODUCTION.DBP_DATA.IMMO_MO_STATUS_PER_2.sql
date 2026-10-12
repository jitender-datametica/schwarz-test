CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_mo_status_per_2 (
mandant_id INTEGER NOT NULL,
mo_status_id INTEGER NOT NULL,
mo_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
dat_status_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
dat_status_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
dat_uebergabe DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
dat_rueckgabe DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);