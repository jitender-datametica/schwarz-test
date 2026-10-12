CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_stueckliste_det (mandant_id, in_art_id,
stueckliste_typ_id, stueckliste_id, stueckliste_pos_id, loesch_fg, stueckliste_pos_typ_id, komponentenmenge,
komponentenmenge_einh_id, kalk_rlv_fg) AS SELECT mandant_id,
 flw_art_id AS in_art_id,
 stueckliste_typ_id,
 stueckliste_id,
 stueckliste_pos_id,
 loesch_fg,
 stueckliste_pos_typ_id,
 komponentenmenge,
 komponentenmenge_einh_id,
 kalk_rlv_fg
FROM kfl_production_dbp_view.v_flw_stueckliste_det;