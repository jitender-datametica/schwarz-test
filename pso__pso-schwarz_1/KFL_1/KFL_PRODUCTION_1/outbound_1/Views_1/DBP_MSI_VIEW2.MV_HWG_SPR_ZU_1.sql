CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_hwg_spr_zu_1 (hwg_id, hwg_bez, mandant_id, arthiertyp_id, spr_id,
abt_id) AS SELECT V01.hwg_id,
 V02.hwg_bez,
 V01.mandant_id,
 V01.arthiertyp_id,
 V02.spr_id,
 V01.abt_id
FROM kfl_production_dbp_view.v_hwg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
  AND V02.spr_id = 22
WHERE V01.mandant_id = 1
 AND V01.arthiertyp_id = 2
 AND V01.dat_bis = DATE '9999-12-31';