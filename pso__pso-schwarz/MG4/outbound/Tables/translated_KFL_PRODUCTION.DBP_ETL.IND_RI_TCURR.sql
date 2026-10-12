CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_ri_tcurr (
voncur STRING(5) COLLATE 'und:ci',
nachcur STRING(5) COLLATE 'und:ci',
rtype STRING(4) COLLATE 'und:ci',
gueltab STRING(8) COLLATE 'und:ci',
faknach INTEGER,
fakvon INTEGER,
kurs STRING(9) COLLATE 'und:ci',
mandant_id INTEGER,
landkz STRING(2),
soursystem STRING(2),
td_update TIMESTAMP,
td_insert TIMESTAMP
);