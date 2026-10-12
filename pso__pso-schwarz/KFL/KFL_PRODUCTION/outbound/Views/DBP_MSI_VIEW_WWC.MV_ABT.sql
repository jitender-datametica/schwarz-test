CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_abt (arthiertyp_id, abt_id, mandant_id, sort_id) AS SELECT
 arthiertyp_id,
 abt_id,
 mandant_id,
 CAST(CASE
   WHEN abt_id <= 0
   THEN abt_id + 1000
   ELSE abt_id
   END AS BIGNUMERIC) AS sort_id
FROM kfl_production_dbp_view.v_abt AS V01
WHERE arthiertyp_id = 2
GROUP BY arthiertyp_id,
 abt_id,
 mandant_id,
 sort_id;