CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_einkaeufer_grp_2 AS SELECT mandant_id,
 einkaeufer_grp_id,
 aktiv_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_einkaeufer_grp_2;