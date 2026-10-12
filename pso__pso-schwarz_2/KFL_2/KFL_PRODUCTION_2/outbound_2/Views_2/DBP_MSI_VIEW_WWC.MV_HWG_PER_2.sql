CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hwg_per_2 (hwg_id, arthiertyp_id, mandant_id, dat_von, dat_bis,
abt_id, hwg_id_sap, mandant_kbez) AS SELECT V01.hwg_id,
 V01.arthiertyp_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V01.abt_id,
 TRIM(CAST(V01.hwg_id AS STRING FORMAT '000')) AS hwg_id_sap,
 V02.mandant_kbez
FROM kfl_production_dbp_view.v_hwg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.arthiertyp_id = 2
 AND V01.hwg_id >= 0;