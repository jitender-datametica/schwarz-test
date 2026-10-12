CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_l_ginfo_flaeche_handel AS SELECT ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 mandant_id,
 techn_platz_id
FROM kfl_production_dbp_view.v_l_ginfo_flaeche
WHERE flaeche_quelle_id = 3;