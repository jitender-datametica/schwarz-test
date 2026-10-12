CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_shr_ma_funktion_gruppe_2 AS SELECT shr_ma_funktion_gruppe_id,
  CASE
  WHEN shr_ma_funktion_gruppe_id < 0
  THEN 1000 - shr_ma_funktion_gruppe_id
  ELSE shr_ma_funktion_gruppe_id
  END AS shr_ma_funktion_sort_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 124
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 108
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 65
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 90
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 95
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 18
     THEN shr_ma_funktion_gruppe_bez
     ELSE NULL
     END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39)))) AS
 shr_ma_funktion_gruppe_bez_bg,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 124
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 108
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 65
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 90
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 95
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 18
    THEN shr_ma_funktion_gruppe_bez
    ELSE NULL
    END), 'MA-Funktion ' || TRIM(SUBSTR(CAST(shr_ma_funktion_gruppe_id AS STRING), 1, 39))) AS
 shr_ma_funktion_gruppe_bez_de
FROM kfl_production_dbp_view.v_shr_ma_funktion_gruppe_spr_zu_2 AS SMFG
GROUP BY shr_ma_funktion_gruppe_id;