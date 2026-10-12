CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_stueckliste_det_1 AS SELECT stueckliste_id,
 stueckliste_pos_id,
 stueckliste_typ_id,
 flw_art_id,
 loesch_fg,
 stueckliste_pos_typ_id,
 komponentenmenge,
 kalk_rlv_fg,
 system_id,
 komponentenmenge_einh_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_stueckliste_det_1;