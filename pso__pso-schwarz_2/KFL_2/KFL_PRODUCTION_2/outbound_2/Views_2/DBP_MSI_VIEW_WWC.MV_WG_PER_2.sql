CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wg_per_2 (mandant_id, mandant_kbez, arthiertyp_id, lead_mwst_id
, matkl, abt_id, dat_von, dat_bis, owg_id, wg_id_sap) AS SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.arthiertyp_id,
 V01.lead_mwst_id,
 V01.wg_id AS matkl,
 V01.abt_id,
 V01.dat_von,
 V01.dat_bis,
 V01.owg_id,
 TRIM(CAST(V01.wg_id AS STRING FORMAT '000')) AS wg_id_sap
FROM kfl_production_dbp_view.v_wg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND V01.arthiertyp_id = 2;