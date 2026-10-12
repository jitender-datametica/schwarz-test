CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_leistung_wg_zu_2 AS SELECT V01.mandant_id,
 V01.bvv_leist_id,
 V02.psp_end_nr,
 V01.in_wg_id
FROM kfl_production_dbp_view.v_leistung_psp_wg_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_bvv_leistung_2 AS V02 ON V01.bvv_leist_id = V02.bvv_leist_id;