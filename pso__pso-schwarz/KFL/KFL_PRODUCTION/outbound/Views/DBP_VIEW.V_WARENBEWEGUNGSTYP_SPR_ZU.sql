CREATE OR REPLACE VIEW kfl_production_dbp_view.v_warenbewegungstyp_spr_zu AS SELECT mandant_id,
 warenbewegungstyp_id,
 spr_id,
 warenbewegungstyp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.warenbewegungstyp_spr_zu;