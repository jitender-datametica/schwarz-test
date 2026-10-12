CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_hwg_wg_spr_zu_1 (hwg_id, hwg_bez, owg_id, owg_bez, wg_id, wg_bez,
mandant_id, arthiertyp_id, spr_id) AS SELECT V01.hwg_id,
 V02.hwg_bez,
 V03.owg_id,
 V04.owg_bez,
 V05.wg_id,
 V06.wg_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V02.spr_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
  AND V02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.hwg_id = V03.hwg_id
 INNER JOIN kfl_production_dbp_view.v_owg_spr_zu_1 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.owg_id = V04.owg_id
  AND V04.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS V05 ON V03.mandant_id = V05.mandant_id AND V03.owg_id = V05.owg_id
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.wg_id = V06.wg_id AND
   V06.spr_id = 22
WHERE V01.mandant_id = 1
 AND V01.arthiertyp_id = 2
 AND V01.dat_bis = DATE '9999-12-31';