CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_temperatur_spr_zu_1 (mandant_id, spr_id, temperatur_id,
temperatur_bez) AS SELECT mandant_id,
 spr_id,
 temperatur_id,
 temperatur_bez
FROM kfl_production_dbp_view.v_temperatur_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;