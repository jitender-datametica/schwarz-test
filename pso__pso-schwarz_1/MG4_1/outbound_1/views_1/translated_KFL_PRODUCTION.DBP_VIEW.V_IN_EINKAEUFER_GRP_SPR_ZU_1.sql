CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_einkaeufer_grp_spr_zu_1 (mandant_id, einkaeufer_grp_id, spr_id,
einkaeufer_grp_bez, td_update, td_insert) AS SELECT mandant_id,
 einkaeufer_grp_id,
 spr_id,
 einkaeufer_grp_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_einkaeufer_grp_spr_zu_1;