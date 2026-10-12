CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_shr_datenfreigabe AS SELECT mandant_id,
 kjmo,
 dat,
 nat_int_fg,
 user_id,
 TIME(0,0,CAST(ROUND(100/1000) AS INT64)) AS freigabe_uhrzeit,
 shr_freigabe_fg,
 dat_freigabe_kennzahlen
FROM kfl_production_dbp_msi_data.shr_datenfreigabe;