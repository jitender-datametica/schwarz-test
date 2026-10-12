CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_besch_lief_2 (
mandant_id INTEGER,
lief_beleg_id INTEGER,
wup_id INTEGER,
nb_id INTEGER,
versandstelle_id STRING(4) COLLATE 'und:ci',
verkaufsorganisation_id STRING(4) COLLATE 'und:ci',
lief_typ_id STRING(4) COLLATE 'und:ci',
dat_lief_soll DATE,
vertr_beleg_typ_id STRING(4) COLLATE 'und:ci',
lief_pal_typ_id STRING(1),
lagerhierarchie_id STRING(4) COLLATE 'und:ci',
kunde_id STRING(10) COLLATE 'und:ci',
auftraggeber_id STRING(10) COLLATE 'und:ci',
anzahl_packstueck INTEGER,
werbeware_id STRING(1) COLLATE 'und:ci',
dat_lagerbew_ist DATE,
system_id INTEGER
);