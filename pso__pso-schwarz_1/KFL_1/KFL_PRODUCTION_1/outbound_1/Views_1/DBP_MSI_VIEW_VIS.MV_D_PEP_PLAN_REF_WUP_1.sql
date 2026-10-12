CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_d_pep_plan_ref_wup_1 (mandant_id, wup_id, ref_wup_id,
ref_wup_id_man, ref_wup_standort) AS SELECT DISTINCT V01.mandant_id,
 V01.wup_id,
 V02.ref_wup_id,
 V03.ref_wup_id AS ref_wup_id_man,
 V04.wup_standort AS ref_wup_standort
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_dialog.d_pep_plan_ref_wup_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
   
 LEFT JOIN kfl_production_dbp_msi_v_view.v_pep_plan_ref_wup_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V02.ref_wup_id
    = V03.wup_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V03.ref_wup_id = V04.wup_id;