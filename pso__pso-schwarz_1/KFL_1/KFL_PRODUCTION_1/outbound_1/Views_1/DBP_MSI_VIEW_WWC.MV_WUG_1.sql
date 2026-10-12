CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wug_1 (mandant_id, mandant_kbez, prdha, matkl, wug_sap) AS
SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.wug_id AS prdha,
 V01.wg_id AS matkl,
  TRIM(CAST(V01.wg_id AS STRING FORMAT '000')) || TRIM(CAST(V01.wug_id AS STRING FORMAT '000')) AS wug_sap
FROM kfl_production_dbp_view.v_wug_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.arthiertyp_id = 2;