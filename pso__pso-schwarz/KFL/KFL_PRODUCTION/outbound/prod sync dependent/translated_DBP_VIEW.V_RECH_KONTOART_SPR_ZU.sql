CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rech_kontoart_spr_zu (mandant_id, spr_id, rech_kontoart_id,
rech_kontoart_bez, system_id) AS SELECT mandant_id,
 spr_id,
 rech_kontoart_id,
 rech_kontoart_bez,
 system_id
FROM kfl_production_dbp_data.rech_kontoart_spr_zu;