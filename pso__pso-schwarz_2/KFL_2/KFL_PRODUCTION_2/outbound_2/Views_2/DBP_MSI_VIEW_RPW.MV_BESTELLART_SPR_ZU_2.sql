CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_bestellart_spr_zu_2 (mandant_id, bestellart_id, spr_id,
bestellart_bez, system_id) AS SELECT mandant_id,
 bestellart_id,
 spr_id,
 bestellart_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_bestellart_spr_zu_2
WHERE spr_id = 22
 AND mandant_id = 1;