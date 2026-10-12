CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vorgangsart_ag08_spr_zu AS SELECT system_id,
 mandant_id,
 spr_id,
 vorgangsart_ag08_id,
 vorgangsart_ag08_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.vorgangsart_ag08_spr_zu;