CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_gp_teilsortiment_1 AS SELECT mandant_id,
 gp_id,
 gp_teilsortiment_id,
 einkaufsorganisation_id,
 zahlungsziel_id,
 zek_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS V01
UNION ALL
SELECT mandant_id,
 gp_id,
 '' AS gp_teilsortiment_id,
 einkaufsorganisation_id,
 zahlungsziel_id,
 zek_id
FROM kfl_production_dbp_view.v_gp_1 AS V02
WHERE (mandant_id, gp_id, '') NOT IN (SELECT (mandant_id, gp_id, gp_teilsortiment_id)
   FROM (SELECT DISTINCT mandant_id,
      gp_id,
      gp_teilsortiment_id
     FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1) AS t2);