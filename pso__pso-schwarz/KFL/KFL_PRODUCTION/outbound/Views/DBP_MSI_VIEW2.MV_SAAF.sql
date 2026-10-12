CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_saaf (bewart_id, bewart_bez, mandant_id, spr_id) AS SELECT
 bewart_id,
 bewart_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_bewart_spr_zu
WHERE bewart_id IN (1001, 1002)
 AND spr_id = 22
 AND mandant_id = 1;