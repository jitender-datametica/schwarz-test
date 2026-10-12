CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_hwg_wg_spr_zu_2 (hwg_id, hwg_bez, owg_id, owg_bez, wg_id, wg_bez
, mandant_id, arthiertyp_id, spr_id) AS SELECT V01.hwg_id,
 V02.hwg_bez,
 V03.owg_id,
 V04.owg_bez,
 V05.wg_id,
 V06.wg_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V02.spr_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
  AND V02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.hwg_id = V03.hwg_id AND
   CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_owg_spr_zu_2 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.owg_id = V04.owg_id
  AND V04.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS V05 ON V03.mandant_id = V05.mandant_id AND V03.owg_id = V05.owg_id AND
   CURRENT_DATE BETWEEN V05.dat_von AND V05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_2 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.wg_id = V06.wg_id AND
   V06.spr_id = 22
WHERE V01.mandant_id = 1
 AND CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis;