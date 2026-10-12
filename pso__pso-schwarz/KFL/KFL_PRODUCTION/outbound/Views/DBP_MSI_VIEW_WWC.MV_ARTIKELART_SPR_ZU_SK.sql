CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artikelart_spr_zu_sk (mandant_id, mtart, spr_id,
artikelart_bez) AS SELECT mandant_id,
 artikelart_id AS mtart,
 spr_id,
 artikelart_bez
FROM kfl_production_dbp_view.v_artikelart_spr_zu AS V01
WHERE spr_id = 108;