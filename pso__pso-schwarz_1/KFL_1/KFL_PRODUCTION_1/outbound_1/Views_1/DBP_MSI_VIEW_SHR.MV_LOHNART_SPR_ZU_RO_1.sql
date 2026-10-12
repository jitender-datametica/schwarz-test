CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_lohnart_spr_zu_ro_1 (mandant_id, lohnart_id, spr_id, lohnart_bez
) AS SELECT mandant_id,
 lohnart_id,
 spr_id,
 lohnart_bez
FROM kfl_production_dbp_view.v_lohnart_spr_zu_1 AS V01
WHERE spr_id = 95;