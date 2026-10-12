CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_achsgruppe_spr_zu (mandant_id, achsgruppe_id, spr_id,
achsgruppe_bez) AS SELECT mandant_id,
 achsgruppe_id,
 spr_id,
 achsgruppe_bez
FROM kfl_production_dbp_view.v_achsgruppe_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;