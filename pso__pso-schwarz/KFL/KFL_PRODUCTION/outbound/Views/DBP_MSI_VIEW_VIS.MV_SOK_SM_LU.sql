CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_sm_lu (mandant_id, sok_sm_id, sok_sap_sm_id, sok_sm_bez_de
, sok_sm_bez, sok_sm_bez_cz, sok_sm_bez_sk, sok_sm_bez_hr, sok_sm_bez_pl, sok_sm_bez_ro, sok_sm_bez_bg) AS SELECT
 mandant_id,
 sm_id AS sok_sm_id,
 sap_sm_id AS sok_sap_sm_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN sm_bez
   ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
   END) AS sok_sm_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN sm_bez
   ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
   END) AS sok_sm_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN sm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN sm_bez
    ELSE TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39))
    END)) AS sok_sm_bez_bg
FROM kfl_production_dbp_view.v_sm AS SM
WHERE sm_id BETWEEN 11 AND 19
 AND sap_sm_id = sm_bez
GROUP BY mandant_id,
 sok_sm_id,
 sok_sap_sm_id;