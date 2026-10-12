CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gruppe_mandant_zek_matrix_2 (
  gruppe_id, 
  mandant_id, 
  zek_id, 
  pflegeflag
) AS 

-- First Part of UNION
SELECT 
    V01.lbs_gruppe_id AS gruppe_id,
    V03.mandant_id,
    V02.zek_id,
    CASE
      WHEN (
        SELECT COUNT(*)
        FROM kfl_production_dbp_security.lbs_gruppe_zek_zu_2 AS X
        -- We reference the aliases V01, V02, V03 from the outer scope
        WHERE X.lbs_gruppe_id = V01.lbs_gruppe_id
          AND X.zek_id = V02.zek_id
          AND X.mandant_id = V03.mandant_id
      ) > 0 THEN 1
      ELSE 0
    END AS pflegeflag
FROM kfl_production_dbp_security.lbs_gruppe_2 AS V01
CROSS JOIN kfl_production_dbp_msi_view_lbs.mv_zek_gp_2 AS V02 
INNER JOIN kfl_production_dbp_msi_view_lbs.mv_mandant_2 AS V03 
    ON V02.mandant_id = V03.mandant_id
WHERE V01.lbs_gruppe_id <> 0 
  AND V02.zek_id <> '999'
  AND V01.lbs_gruppe_id NOT IN (
    SELECT lbs_gruppe_parent_id
    FROM kfl_production_dbp_security.lbs_gruppe_gruppe_zu_2
  )

UNION DISTINCT

-- Second Part of UNION
SELECT 
    V01.lbs_gruppe_id,
    V02.mandant_id,
    '-1' AS zek_id,
    0 AS pflegeflag
FROM kfl_production_dbp_security.lbs_gruppe_2 AS V01
CROSS JOIN kfl_production_dbp_msi_view_lbs.mv_mandant_2 AS V02
WHERE V01.lbs_gruppe_id <> 0
  AND V01.lbs_gruppe_id NOT IN (
    SELECT lbs_gruppe_id
    FROM kfl_production_dbp_security.lbs_gruppe_zek_zu_2
    WHERE alle_zek_fg = 1
      AND zek_id = '-1'
  )
  AND V01.lbs_gruppe_id NOT IN (
    SELECT lbs_gruppe_parent_id
    FROM kfl_production_dbp_security.lbs_gruppe_gruppe_zu_2
  );
