CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_tag_spr_zu AS SELECT TAG.dat,
 TAG.wtag_id,
 MAX(CASE
   WHEN SPR.spr_id = 22
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez,
 MAX(CASE
   WHEN SPR.spr_id = 22
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_de,
 MAX(CASE
   WHEN SPR.spr_id = 124
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_cz,
 MAX(CASE
   WHEN SPR.spr_id = 90
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_pl,
 MAX(CASE
   WHEN SPR.spr_id = 108
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_sk,
 MAX(CASE
   WHEN SPR.spr_id = 65
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_hr,
 MAX(CASE
   WHEN SPR.spr_id = 95
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_ro,
 MAX(CASE
   WHEN SPR.spr_id = 18
   THEN SPR.wtag_bez
   ELSE NULL
   END) AS wtag_bez_bg,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 22
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 22
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_de,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 124
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_cz,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 90
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_pl,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 108
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_sk,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 65
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_hr,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 95
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_ro,
 CAST(MAX(CASE
    WHEN SPR.spr_id = 18
    THEN TRIM(SUBSTR(SPR.wtag_bez, 1, 2))
    ELSE NULL
    END) AS STRING) AS wtag_kbez_bg
FROM kfl_production_dbp_view.v_tag AS TAG
 INNER JOIN kfl_production_dbp_view.v_wtag_spr_zu AS SPR ON TAG.wtag_id = SPR.wtag_id
WHERE TAG.akt_gj BETWEEN - 10 AND 1
GROUP BY TAG.dat,
 TAG.wtag_id;