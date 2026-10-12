CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_tqm_massentest_1 (mandant_id, in_lief_id, in_art_id,
dat_test, pc_id, krk_id, anz_stck_geprueft, anz_kf_fehler, anz_vk_fehler) AS SELECT mandant_id,
 flw_lief_id AS in_lief_id,
 flw_art_id AS in_art_id,
 dat_test,
 pc_id,
 krk_id,
 anz_stck_geprueft,
 anz_kf_fehler,
 anz_vk_fehler
FROM kfl_production_dbp_view.v_flw_tqm_massentest_1 AS V01;