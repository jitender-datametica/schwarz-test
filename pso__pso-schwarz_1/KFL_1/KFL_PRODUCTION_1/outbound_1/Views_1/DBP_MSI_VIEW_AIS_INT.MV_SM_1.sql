CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sm_1 (mandant_id, sm_id, sm_kbez, sm_bez, sm_bez_de,
sm_bez_cz, sm_bez_sk, sm_bez_hr, sm_bez_pl, sm_bez_ro, sm_bez_bg, sap_sm_id) AS SELECT mandant_id,
 CAST(TRIM(CASE
    WHEN sm_id IN (11, 12, 13, 14, 15, 16, 17, 18, 19)
    THEN sap_sm_id
    ELSE CAST(sm_id AS STRING)
    END) AS STRING) AS sm_id,
  CASE
  WHEN sm_id = -1
  THEN 'keine'
  ELSE CAST(sm_id AS STRING)
  END AS sm_kbez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE NULL
    END), 'N/A') AS sm_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE NULL
    END), 'N/A') AS sm_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN sm_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN sm_bez
     ELSE NULL
     END), 'N/A')) AS sm_bez_bg,
 sap_sm_id
FROM kfl_production_dbp_view.v_sm_1 AS V01
GROUP BY mandant_id,
 V01.sm_id,
 sm_kbez,
 sap_sm_id;