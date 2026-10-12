CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sortimentslistenart_spr_zu AS SELECT mandant_id,
 sortimentslistenart_id,
 spr_id,
 sortimentslistenart_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.sortimentslistenart_spr_zu;