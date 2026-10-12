CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_hwg_wg_zu_per_1 (hwg_id, owg_id, wg_id, mandant_id, dat_von,
dat_bis, arthiertyp_id) AS SELECT V01.hwg_id,
 V02.owg_id,
 V03.wg_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id AND
   CURRENT_DATE BETWEEN V02.dat_von AND V02.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.owg_id = V03.owg_id AND
   CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
WHERE CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis;