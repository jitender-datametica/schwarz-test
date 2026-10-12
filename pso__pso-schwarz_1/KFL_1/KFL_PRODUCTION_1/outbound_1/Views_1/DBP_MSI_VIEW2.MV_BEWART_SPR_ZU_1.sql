CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_bewart_spr_zu_1 (spr_id, bewart_id, bewart_bez, mandant_id) AS
SELECT spr_id,
 bewart_id,
 bewart_bez,
 mandant_id
FROM kfl_production_dbp_view.v_bewart_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;