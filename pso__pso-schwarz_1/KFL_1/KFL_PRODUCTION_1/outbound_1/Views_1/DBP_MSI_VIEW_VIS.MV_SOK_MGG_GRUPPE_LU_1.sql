CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_mgg_gruppe_lu_1 (mandant_id, sok_mgg_gruppe_id,
sok_mgg_abteilung_id, sok_mgg_gruppe_bez_de, sok_mgg_gruppe_bez, sok_mgg_gruppe_bez_cz, sok_mgg_gruppe_bez_sk,
sok_mgg_gruppe_bez_hr, sok_mgg_gruppe_bez_pl, sok_mgg_gruppe_bez_ro, sok_mgg_gruppe_bez_bg) AS SELECT GRP.mandant_id,
 GRP.mgg_gruppe_id AS sok_mgg_gruppe_id,
 GRP.mgg_abteilung_id AS sok_mgg_abteilung_id,
 MAX(CASE
   WHEN GRPS.spr_id = 22
   THEN GRPS.mgg_gruppe_bez
   ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
   END) AS sok_mgg_gruppe_bez_de,
 MAX(CASE
   WHEN GRPS.spr_id = 22
   THEN GRPS.mgg_gruppe_bez
   ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
   END) AS sok_mgg_gruppe_bez,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 124
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 108
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 65
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 90
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 95
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN GRPS.spr_id = 18
    THEN GRPS.mgg_gruppe_bez
    ELSE NULL
    END), MAX(CASE
    WHEN GRPS.spr_id = 22
    THEN GRPS.mgg_gruppe_bez
    ELSE TRIM(SUBSTR(CAST(GRPS.mgg_gruppe_id AS STRING), 1, 39))
    END)) AS sok_mgg_gruppe_bez_bg
FROM kfl_production_dbp_view.v_l_mgg_gruppe_1 AS GRP
 INNER JOIN kfl_production_dbp_view.v_mgg_gruppe_spr_zu_1 AS GRPS ON GRP.mandant_id = GRPS.mandant_id AND GRP.mgg_gruppe_id
    = GRPS.mgg_gruppe_id
GROUP BY GRP.mandant_id,
 sok_mgg_gruppe_id,
 sok_mgg_abteilung_id;