CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_flaeche_typ_1 AS SELECT flaeche_typ_id,
 spr_id,
 mandant_id,
 flaeche_typ_bez
FROM kfl_production_dbp_view.v_ivs_l_flaeche_typ_1
WHERE spr_id = 22;