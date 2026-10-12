CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_mzk_grund_1 (geku_mzk_grund_uid, geku_mzk_thema_uid, td_update,
td_insert) AS SELECT geku_mzk_grund_uid,
 geku_mzk_thema_uid,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_mzk_grund_1;