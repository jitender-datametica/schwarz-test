CREATE OR REPLACE VIEW kfl_production_dbp_view.v_diff_spr_zu_2 AS SELECT mandant_id,
 diff_id,
 spr_id,
 diff_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.diff_spr_zu_2;