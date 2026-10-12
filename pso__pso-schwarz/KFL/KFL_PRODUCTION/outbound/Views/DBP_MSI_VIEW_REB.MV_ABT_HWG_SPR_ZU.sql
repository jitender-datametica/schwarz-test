CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_abt_hwg_spr_zu (abt_id, abt_bez, hwg_id, hwg_bez, mandant_id,
arthiertyp_id, spr_id) AS SELECT V01.abt_id,
 V02.abt_bez,
 V03.hwg_id,
 V04.hwg_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V02.spr_id
FROM kfl_production_dbp_view.v_abt AS V01
 INNER JOIN kfl_production_dbp_view.v_abt_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abt_id = V02.abt_id
  AND V02.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_hwg_per AS V03 ON V01.mandant_id = V03.mandant_id AND V01.abt_id = V03.abt_id AND
   CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu AS V04 ON V03.mandant_id = V04.mandant_id AND V03.hwg_id = V04.hwg_id
  AND V04.spr_id = 22
WHERE V01.mandant_id = 1;