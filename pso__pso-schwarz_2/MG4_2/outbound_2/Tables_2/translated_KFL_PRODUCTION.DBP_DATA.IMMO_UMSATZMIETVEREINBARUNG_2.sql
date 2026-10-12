CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_umsatzmietvereinbarung_2 (
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
umsatzregel STRING(4) COLLATE 'und:ci' NOT NULL,
melderegel STRING(4) COLLATE 'und:ci' NOT NULL,
ums_staffel_lfd_nr INTEGER NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci',
einheit STRING(3) COLLATE 'und:ci',
umsatz_min NUMERIC(18,2) NOT NULL,
umsatz_max NUMERIC(18,2) NOT NULL,
miete_umsatz_prozent NUMERIC(9,2) NOT NULL,
absatz_min NUMERIC(18,4) NOT NULL,
absatz_max NUMERIC(18,4) NOT NULL,
betrag_einheit NUMERIC(19,6) NOT NULL,
ums_staffel_mindestmiete NUMERIC(18,2) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);