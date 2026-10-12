CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_tarifgebiet_spr_zu_pl_1 (mandant_id, tarifgebiet_id, spr_id,
tarifgebiet_bez) AS SELECT mandant_id,
 tarifgebiet_id,
 spr_id,
 tarifgebiet_bez
FROM kfl_production_dbp_view.v_tarifgebiet_spr_zu_1 AS V01
WHERE spr_id = 90;