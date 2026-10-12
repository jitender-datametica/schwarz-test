CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_owg_per_2 AS SELECT DISTINCT V01.owg_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V01.hwg_id
FROM kfl_production_dbp_view.v_owg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.owg_id = V02.owg_id
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wg_id = V03.wg_id
WHERE CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis;