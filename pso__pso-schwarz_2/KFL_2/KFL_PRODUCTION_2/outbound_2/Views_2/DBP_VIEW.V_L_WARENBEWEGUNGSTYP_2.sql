CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_warenbewegungstyp_2 AS SELECT mandant_id,
 warenbewegungstyp_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_warenbewegungstyp_2;