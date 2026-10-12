CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sortimentslistenart_spr_zu (mandant_id, spr_id,
sortimentslistenart_id, sortimentslistenart_bez) AS SELECT mandant_id,
 spr_id,
 sortimentslistenart_id,
 sortimentslistenart_bez
FROM kfl_production_dbp_data.sortimentslistenart_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;