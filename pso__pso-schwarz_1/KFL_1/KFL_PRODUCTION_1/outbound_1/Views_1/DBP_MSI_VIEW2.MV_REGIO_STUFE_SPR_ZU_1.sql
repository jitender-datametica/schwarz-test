CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_stufe_spr_zu_1 (mandant_id, regio_stufe_id, spr_id,
regio_stufe_bez) AS SELECT mandant_id,
 regio_stufe_id,
 spr_id,
 regio_stufe_bez
FROM kfl_production_dbp_view.v_regio_stufe_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;