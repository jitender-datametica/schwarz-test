CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ruecksendung_status_lu_1 (ruecksendung_status_id,
ruecksendung_status_bez_de, ruecksendung_status_bez, ruecksendung_status_bez_cz, ruecksendung_status_bez_sk,
ruecksendung_status_bez_hr, ruecksendung_status_bez_pl, ruecksendung_status_bez_ro, ruecksendung_status_bez_bg) AS
SELECT RS.ruecksendung_status_id,
 MAX(CASE
   WHEN RSS.spr_id = 22
   THEN RSS.ruecksendung_status_bez
   ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
   END) AS ruecksendung_status_bez_de,
 MAX(CASE
   WHEN RSS.spr_id = 22
   THEN RSS.ruecksendung_status_bez
   ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
   END) AS ruecksendung_status_bez,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 124
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_cz,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 108
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_sk,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 65
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_hr,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 90
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_pl,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 95
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_ro,
 COALESCE(MAX(CASE
    WHEN RSS.spr_id = 18
    THEN RSS.ruecksendung_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN RSS.spr_id = 22
    THEN RSS.ruecksendung_status_bez
    ELSE TRIM(SUBSTR(CAST(RSS.ruecksendung_status_id AS STRING), 1, 39))
    END)) AS ruecksendung_status_bez_bg
FROM kfl_production_dbp_view.v_l_ruecksendung_status_1 AS RS_1
 INNER JOIN kfl_production_dbp_view.v_ruecksendung_status_spr_zu_1 AS RSS ON RS.mandant_id = RSS.mandant_id AND RS.ruecksendung_status_id
    = RSS.ruecksendung_status_id
GROUP BY RS.ruecksendung_status_id;