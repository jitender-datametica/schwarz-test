CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_flw_schnittliste_det_2 (
mandant_id INTEGER,
schnittliste_id INTEGER,
schnitt_id INTEGER,
sek_schl_typ_id STRING(1) COLLATE 'und:ci',
sek_schl_id INTEGER,
schnitt_verwendung_prozent NUMERIC(29,2)
);