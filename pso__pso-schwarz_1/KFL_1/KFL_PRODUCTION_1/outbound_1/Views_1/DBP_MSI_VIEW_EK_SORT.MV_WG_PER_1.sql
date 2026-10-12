CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_wg_per_1 AS SELECT V01.wg_id,
 V01.dat_von,
 V01.abt_id,
 V01.mandant_id,
 V01.dat_bis,
 V01.owg_id
FROM kfl_production_dbp_view.v_wg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_id = V02.wg_id
WHERE V01.dat_bis > CURRENT_DATE
 AND V02.wg_filter_id = 11;