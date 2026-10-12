CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_abt_hwg_zu_per_1 (abt_id, hwg_id, mandant_id, dat_von, dat_bis,
arthiertyp_id) AS SELECT V01.abt_id,
 V02.hwg_id,
 V01.mandant_id,
 V02.dat_von,
 V02.dat_bis,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_abt_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.abt_id = V02.abt_id
WHERE V01.mandant_id = 1
 AND V02.arthiertyp_id = 2
 AND V02.dat_bis = DATE '9999-12-31';