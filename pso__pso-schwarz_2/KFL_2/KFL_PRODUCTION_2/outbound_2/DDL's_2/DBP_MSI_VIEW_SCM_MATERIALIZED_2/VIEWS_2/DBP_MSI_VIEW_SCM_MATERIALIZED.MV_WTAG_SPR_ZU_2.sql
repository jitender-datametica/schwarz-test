CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wtag_spr_zu_2 (wtag_id, wtag_bez, wtag_bez_de,
wtag_bez_cz, wtag_bez_pl, wtag_bez_sk, wtag_bez_hr, wtag_bez_ro, wtag_bez_bg, wtag_kbez, wtag_kbez_de, wtag_kbez_cz,
wtag_kbez_pl, wtag_kbez_sk, wtag_kbez_hr, wtag_kbez_ro, wtag_kbez_bg) AS SELECT wtag_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_bg,
 CAST(MAX(CASE
    WHEN spr_id = 22
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez,
 CAST(MAX(CASE
    WHEN spr_id = 22
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_de,
 CAST(MAX(CASE
    WHEN spr_id = 124
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_cz,
 CAST(MAX(CASE
    WHEN spr_id = 90
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_pl,
 CAST(MAX(CASE
    WHEN spr_id = 108
    THEN TRIM(SUBSTR(wtag_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_sk,
 CAST(MAX(CASE
    WHEN spr_id = 65
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_hr,
 CAST(MAX(CASE
    WHEN spr_id = 95
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_ro,
 CAST(MAX(CASE
    WHEN spr_id = 18
    THEN TRIM(SUBSTR(wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_bg
FROM kfl_production_dbp_view.v_wtag_spr_zu_2 AS SPR_2
GROUP BY wtag_id;