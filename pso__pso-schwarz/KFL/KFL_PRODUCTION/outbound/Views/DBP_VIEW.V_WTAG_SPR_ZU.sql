CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wtag_spr_zu AS SELECT wtag_id,
 spr_id,
 wtag_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.wtag_spr_zu;