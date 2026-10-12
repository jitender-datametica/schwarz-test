CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_kurs_tmp (
kurstyp_id INTEGER NOT NULL,
von_wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
nach_wrg_id STRING(3) COLLATE 'und:ci',
dat_von DATE NOT NULL,
dat_bis DATE,
umrechnungskurs FLOAT64,
berech_fg INTEGER,
soursystem STRING(2) COLLATE 'und:ci',
rtype STRING(4) COLLATE 'und:ci',
voncur STRING(5) COLLATE 'und:ci',
nachcur STRING(5) COLLATE 'und:ci',
gueltab STRING(8) COLLATE 'und:ci'
);