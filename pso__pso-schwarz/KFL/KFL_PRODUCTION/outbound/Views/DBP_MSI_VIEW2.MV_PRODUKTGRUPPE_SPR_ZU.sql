CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_produktgruppe_spr_zu (mandant_id, produktgruppe_id, spr_id,
produktgruppe_bez) AS SELECT mandant_id,
 produktgruppe_id,
 spr_id,
 produktgruppe_bez
FROM kfl_production_dbp_view.v_produktgruppe_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;