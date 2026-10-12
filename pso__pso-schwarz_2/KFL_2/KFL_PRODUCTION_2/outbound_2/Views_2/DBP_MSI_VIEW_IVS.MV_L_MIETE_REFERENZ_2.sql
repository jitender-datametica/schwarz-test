CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_miete_referenz_2 AS SELECT miete_referenz_id,
 spr_id,
 mandant_id,
 miete_referenz_bez
FROM kfl_production_dbp_view.v_ivs_l_miete_referenz_2
WHERE spr_id = 22;