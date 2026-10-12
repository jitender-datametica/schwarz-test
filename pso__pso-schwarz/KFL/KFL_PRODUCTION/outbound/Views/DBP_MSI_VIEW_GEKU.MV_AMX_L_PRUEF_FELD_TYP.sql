CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_pruef_feld_typ (pruef_feld_typ_id, amx_system_id,
pruef_feld_typ_bez, pruef_feld_typ_typ_id) AS SELECT pruef_feld_typ_id,
 amx_system_id,
 pruef_feld_typ_bez,
 pruef_feld_typ_typ_id
FROM kfl_production_dbp_view.v_amx_l_pruef_feld_typ
WHERE pruef_feld_typ_typ_id = 1;