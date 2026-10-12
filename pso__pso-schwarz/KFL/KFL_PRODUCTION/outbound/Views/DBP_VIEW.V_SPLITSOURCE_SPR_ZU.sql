CREATE OR REPLACE VIEW kfl_production_dbp_view.v_splitsource_spr_zu AS SELECT mandant_id,
 spr_id,
 splitsource_id,
 splitsource_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.splitsource_spr_zu;