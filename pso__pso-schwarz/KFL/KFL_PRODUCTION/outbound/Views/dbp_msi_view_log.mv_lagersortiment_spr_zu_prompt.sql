CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagersortiment_spr_zu_prompt AS SELECT lagersortiment_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagersortiment_bez
   ELSE NULL
   END) AS lagersortiment_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagersortiment_bez
   ELSE NULL
   END) AS lagersortiment_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagersortiment_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagersortiment_bez
    ELSE NULL
    END)) AS lagersortiment_bez_bg
FROM kfl_production_dbp_view.v_lagersortiment_spr_zu AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY lagersortiment_id
UNION ALL
SELECT CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN '0'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN '9'
  ELSE NULL
  END AS lagersortiment_id,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'nicht definiert'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Leergut'
  ELSE NULL
  END AS lagersortiment_bez,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'nicht definiert'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Leergut'
  ELSE NULL
  END AS lagersortiment_bez_de,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_cz,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_sk,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_hr,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_pl,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_ro,
  CASE
  WHEN CAST(lagersortiment_id AS FLOAT64) = 1
  THEN 'not defined'
  WHEN CAST(lagersortiment_id AS FLOAT64) = 2
  THEN 'Empties'
  ELSE NULL
  END AS lagersortiment_bez_bg
FROM kfl_production_dbp_view.v_lagersortiment_spr_zu AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND lagersortiment_id IN ('1', '2')
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY V01.lagersortiment_id;