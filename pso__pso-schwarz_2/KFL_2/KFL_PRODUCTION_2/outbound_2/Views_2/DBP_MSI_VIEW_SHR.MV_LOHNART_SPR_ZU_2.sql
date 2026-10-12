CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_lohnart_spr_zu_2 (mandant_id, lohnart_id, spr_id, lohnart_bez)
AS SELECT V01.mandant_id,
 V01.lohnart_id,
 V01.spr_id,
 V01.lohnart_bez
FROM kfl_production_dbp_view.v_lohnart_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.spr_id = V04.spr_id;