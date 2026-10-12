CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_lohnart_spr_zu_1 (mandant_id, lohnart_id, spr_id, lohnart_bez)
AS SELECT v01.mandant_id,
 v01.lohnart_id,
 v01.spr_id,
 v01.lohnart_bez
FROM kfl_production_dbp_view.v_lohnart_spr_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_1 AS v04 ON v01.mandant_id = v04.mandant_id AND v01.spr_id = v04.spr_id;