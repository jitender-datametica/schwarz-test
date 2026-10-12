CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_qual_meldung_det_2 (
mandant_id INTEGER,
qual_meldung_id INTEGER,
qual_meldung_pos_id INTEGER,
katalogart_id STRING(1) COLLATE 'und:ci',
codegruppe_id STRING(10) COLLATE 'und:ci',
pruefcode_id STRING(4) COLLATE 'und:ci',
fehlgrund_id STRING(40) COLLATE 'und:ci',
fehlerklasse_id INTEGER,
kopf_fehlerpunkte NUMERIC(29,5),
fehlgrund_gefiltert_bez STRING(40) COLLATE 'und:ci'
);