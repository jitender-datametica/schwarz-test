CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_art_wup_status AS SELECT in_art_id,
 werk_id,
 mandant_id,
 system_id,
 einkaeufer_grp_id,
 in_dispomerkmal,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_art_wup_status;