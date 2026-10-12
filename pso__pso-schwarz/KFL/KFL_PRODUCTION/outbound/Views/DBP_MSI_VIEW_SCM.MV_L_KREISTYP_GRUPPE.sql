CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_kreistyp_gruppe AS SELECT mandant_id,
 kreistyp_gruppe_id
FROM kfl_production_dbp_view.v_l_kreistyp_gruppe AS V01
UNION ALL
SELECT mandant_id,
 '' AS kreistyp_id
FROM kfl_production_dbp_view.v_mandant AS V02
WHERE mandant_id NOT IN (SELECT mandant_id
   FROM kfl_production_dbp_view.v_l_kreistyp_gruppe
   WHERE kreistyp_gruppe_id = '');