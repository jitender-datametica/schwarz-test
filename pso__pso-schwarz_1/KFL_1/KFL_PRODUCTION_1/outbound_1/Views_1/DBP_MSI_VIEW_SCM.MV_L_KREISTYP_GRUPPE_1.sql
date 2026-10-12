CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_kreistyp_gruppe_1 AS SELECT mandant_id,
 kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_l_kreistyp_gruppe_1 AS V01
UNION ALL
SELECT mandant_id,
 '' AS kreistyp_id
FROM kfl_production_dbp_view.v_mandant_1 AS V02
WHERE mandant_id NOT IN (SELECT mandant_id
   FROM kfl_production_dbp_view.v_l_kreistyp_gruppe_1
   WHERE kreistyp_gruppe_id = '');