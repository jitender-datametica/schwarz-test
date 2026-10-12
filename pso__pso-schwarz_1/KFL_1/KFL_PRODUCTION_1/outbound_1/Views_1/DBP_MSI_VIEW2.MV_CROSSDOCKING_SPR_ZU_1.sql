CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_crossdocking_spr_zu_1 (mandant_id, crossdocking_id, spr_id,
crossdocking_bez) AS SELECT mandant_id,
 crossdocking_id,
 spr_id,
 crossdocking_bez
FROM kfl_production_dbp_data.crossdocking_spr_zu_1 AS V01
WHERE mandant_id = 1
 AND spr_id = 22;