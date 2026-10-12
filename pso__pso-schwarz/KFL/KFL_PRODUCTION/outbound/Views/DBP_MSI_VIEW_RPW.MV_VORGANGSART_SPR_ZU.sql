CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_vorgangsart_spr_zu (mandant_id, vorgangsart_id, spr_id,
vorgangsart_bez, system_id) AS SELECT mandant_id,
 vorgangsart_id,
 spr_id,
 vorgangsart_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_vorgangsart_spr_zu
WHERE spr_id = 22
 AND mandant_id = 1;