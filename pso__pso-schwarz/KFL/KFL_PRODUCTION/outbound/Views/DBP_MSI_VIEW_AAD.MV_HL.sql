CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_hl AS SELECT mandant_id,
 ma_id AS hl_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
   ELSE NULL
   END) AS hl_name,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS hl_name_bg
FROM kfl_production_dbp_view.v_ma_spr_zu AS MSZ
WHERE (mandant_id, ma_id) IN (SELECT (mandant_id, hl_id)
   FROM (SELECT mandant_id,
       hl_id
      FROM kfl_production_dbp_view.v_wup
      UNION ALL
      SELECT mandant_id,
         (1000 + mandant_id * 100 + vs_id * 10) * - 1
      FROM kfl_production_dbp_view.v_vs) AS t1)
GROUP BY mandant_id,
 hl_id;