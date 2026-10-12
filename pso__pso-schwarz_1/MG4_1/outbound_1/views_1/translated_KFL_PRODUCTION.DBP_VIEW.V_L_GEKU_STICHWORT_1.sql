CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_stichwort_1 (geku_stichwort_uid, td_update, td_insert) AS SELECT
 geku_stichwort_uid,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_stichwort_1;