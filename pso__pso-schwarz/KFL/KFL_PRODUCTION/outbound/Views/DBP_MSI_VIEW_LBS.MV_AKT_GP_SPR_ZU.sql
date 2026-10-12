CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_akt_gp_spr_zu (mandant_id, akt_gp_id, akt_gp_name,
akt_gp_name_de, akt_gp_name_cz, akt_gp_name_pl, akt_gp_name_md, akt_gp_name_sk, akt_gp_name_hr, akt_gp_name_ro,
akt_gp_name_bg) AS SELECT mandant_id,
 gp_id AS akt_gp_id,
 gp_name_lat AS akt_gp_name,
 gp_name_lat AS akt_gp_name_de,
 gp_name_lat AS akt_gp_name_cz,
 gp_name_lat AS akt_gp_name_pl,
 gp_name_lat AS akt_gp_name_md,
 gp_name_lat AS akt_gp_name_sk,
 gp_name_lat AS akt_gp_name_hr,
 gp_name_lat AS akt_gp_name_ro,
 gp_name AS akt_gp_name_bg
FROM kfl_production_dbp_view.v_gp AS V01;