CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_artikelsortiment_spr_zu_2 AS ((SELECT SUBSTR(CAST(V01.artikelsortiment_id AS STRING)
    , 1, 2) AS artikelsortiment_id,
   V03.mandant_id,
   V03.lagernummer_id,
   MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END) AS artikelsortiment_bez,
   MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END) AS artikelsortiment_bez_de,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 124
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_cz,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 108
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_sk,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 65
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_hr,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 90
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_pl,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 95
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_ro,
   COALESCE(MAX(CASE
      WHEN V01.spr_id = 18
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END), MAX(CASE
      WHEN V01.spr_id = 22
      THEN V01.artikelsortiment_bez
      ELSE NULL
      END)) AS artikelsortiment_bez_bg
  FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS V03 ON V03.ewm_fg = 1
  GROUP BY V01.artikelsortiment_id,
   V03.mandant_id,
   V03.lagernummer_id
  UNION DISTINCT
  SELECT '-1' AS artikelsortiment_id,
   V03.mandant_id,
   V03.lagernummer_id,
   'N/A' AS artikelsortiment_bez,
   'N/A' AS artikelsortiment_bez_de,
   'N/A' AS artikelsortiment_bez_cz,
   'N/A' AS artikelsortiment_bez_sk,
   'N/A' AS artikelsortiment_bez_hr,
   'N/A' AS artikelsortiment_bez_pl,
   'N/A' AS artikelsortiment_bez_ro,
   'N/A' AS artikelsortiment_bez_bg
  FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_l_lagernummer_2 AS V03 ON V03.ewm_fg = 1
  GROUP BY V01.artikelsortiment_id,
   V03.mandant_id,
   V03.lagernummer_id)
 UNION DISTINCT
 SELECT SUBSTR(CAST(V01.artikelsortiment_id AS STRING), 1, 2) AS artikelsortiment_id,
  V03.mandant_id,
  V03.lagernummer_les_id,
  MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikelsortiment_bez
    ELSE NULL
    END) AS artikelsortiment_bez,
  MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.artikelsortiment_bez
    ELSE NULL
    END) AS artikelsortiment_bez_de,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 124
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_cz,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 108
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_sk,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 65
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_hr,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 90
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_pl,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 95
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_ro,
  COALESCE(MAX(CASE
     WHEN V01.spr_id = 18
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.artikelsortiment_bez
     ELSE NULL
     END)) AS artikelsortiment_bez_bg
 FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_2 AS V01
  INNER JOIN kfl_production_dbp_view.v_ts_mercareon_mapping_2 AS V03 ON TRUE
 GROUP BY V01.artikelsortiment_id,
  V03.mandant_id,
  V03.lagernummer_les_id)
UNION DISTINCT
SELECT '-1' AS artikelsortiment_id,
 V03.mandant_id,
 V03.lagernummer_les_id,
 'N/A' AS artikelsortiment_bez,
 'N/A' AS artikelsortiment_bez_de,
 'N/A' AS artikelsortiment_bez_cz,
 'N/A' AS artikelsortiment_bez_sk,
 'N/A' AS artikelsortiment_bez_hr,
 'N/A' AS artikelsortiment_bez_pl,
 'N/A' AS artikelsortiment_bez_ro,
 'N/A' AS artikelsortiment_bez_bg
FROM kfl_production_dbp_view.v_artikelsortiment_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_ts_mercareon_mapping_2 AS V03 ON TRUE
GROUP BY V01.artikelsortiment_id,
 V03.mandant_id,
 V03.lagernummer_les_id;