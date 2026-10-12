CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_kurs_tmp2 (
mandant_id INTEGER NOT NULL,
kurstyp_id INTEGER NOT NULL,
von_wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
nach_wrg_id STRING(3) COLLATE 'und:ci',
dat_von DATE NOT NULL,
dat_bis DATE,
umrechnungskurs FLOAT64
);