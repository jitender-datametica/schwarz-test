CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flag_spr_zu_2 AS SELECT flag,
 flag_typ_id,
 spr_id,
 flag_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flag_spr_zu_2;