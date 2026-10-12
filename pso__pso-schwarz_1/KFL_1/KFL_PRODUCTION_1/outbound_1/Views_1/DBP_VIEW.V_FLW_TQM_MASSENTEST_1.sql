CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_tqm_massentest_1 AS SELECT flw_lief_id,
 mandant_id,
 flw_art_id,
 dat_test,
 pc_id,
 krk_id,
 anz_stck_geprueft,
 anz_kf_fehler,
 anz_vk_fehler,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_tqm_massentest_1;