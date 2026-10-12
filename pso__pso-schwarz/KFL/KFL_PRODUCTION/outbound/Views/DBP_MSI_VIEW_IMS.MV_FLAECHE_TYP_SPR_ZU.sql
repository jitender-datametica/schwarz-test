CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_flaeche_typ_spr_zu AS SELECT ginfo_flaeche_typ_id,
 mandant_id,
 ginfo_flaeche_typ_bez
FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu
WHERE spr_id = 22;