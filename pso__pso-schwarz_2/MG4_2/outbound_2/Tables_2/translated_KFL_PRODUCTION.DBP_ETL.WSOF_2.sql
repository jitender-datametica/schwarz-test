CREATE OR REPLACE TABLE kfl_production_dbp_etl.wsof_2 (
mandt INTEGER NOT NULL,
sart STRING(1) COLLATE 'und:ci',
skopf INTEGER NOT NULL,
filiale INTEGER NOT NULL,
datuv DATE,
datub DATE NOT NULL,
lvorm STRING(1) COLLATE 'und:ci'
);