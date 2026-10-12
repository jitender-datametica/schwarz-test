CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_posten_sap AS SELECT mandant_id,
 posten_kz_sap,
  CASE
  WHEN posten_kz_sap = ''
  THEN 'nicht gepflegt'
  ELSE posten_bez_sap
  END AS posten_bez_sap
FROM kfl_production_dbp_view.v_posten_kz_sap_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
UNION DISTINCT
SELECT mandant_id,
 posten_id AS posten_kz_sap,
  CASE
  WHEN posten_id = ''
  THEN 'nicht gepflegt'
  ELSE posten_bez
  END AS posten_bez_sap
FROM kfl_production_dbp_view.v_artkz_posten
WHERE mandant_id = 1
 AND spr_id = 22;