CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_sortimentslistenart_spr_zu_1 (mandant_id, spr_id,
sortimentslistenart_id, sortimentslistenart_bez) AS SELECT mandant_id,
 spr_id,
 sortimentslistenart_id,
 sortimentslistenart_bez
FROM kfl_production_dbp_view.v_sortimentslistenart_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;