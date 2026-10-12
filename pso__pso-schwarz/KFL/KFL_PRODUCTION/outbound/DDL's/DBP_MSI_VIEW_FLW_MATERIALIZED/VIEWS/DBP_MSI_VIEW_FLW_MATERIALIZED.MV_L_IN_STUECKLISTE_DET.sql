CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_in_stueckliste_det (mandant_id, stueckliste_id
, stueckliste_pos_id, stueckliste_typ_id, in_art_id, in_art_nr, art_bez) AS SELECT V01.mandant_id,
 V01.stueckliste_id,
 V01.stueckliste_pos_id,
 V01.stueckliste_typ_id,
 V01.in_art_id,
 V01.in_art_nr,
 V01.art_bez
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_l_in_stueckliste_det AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V04 ON V01.spr_id = V04.spr_id;