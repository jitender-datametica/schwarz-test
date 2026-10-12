CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_datumsart_spr_zu_sk_2 (mandant_id, datumsart_id, datumsart_bez)
AS SELECT mandant_id,
 datumsart_id,
 datumsart_bez
FROM kfl_production_dbp_view.v_datumsart_spr_zu_2 AS V01
WHERE spr_id = 108;