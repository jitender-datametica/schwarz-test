CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ruecksendung_bezugsweg_lu (bezugsweg_id, bezugsweg_bez_de,
bezugsweg_bez, bezugsweg_bez_cz, bezugsweg_bez_sk, bezugsweg_bez_hr, bezugsweg_bez_pl, bezugsweg_bez_ro,
bezugsweg_bez_bg) AS SELECT BW.bezugsweg_id,
 MAX(CASE
   WHEN BWS.spr_id = 22
   THEN BWS.bezugsweg_bez
   ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
   END) AS bezugsweg_bez_de,
 MAX(CASE
   WHEN BWS.spr_id = 22
   THEN BWS.bezugsweg_bez
   ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
   END) AS bezugsweg_bez,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 124
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_cz,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 108
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_sk,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 65
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_hr,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 90
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_pl,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 95
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_ro,
 COALESCE(MAX(CASE
    WHEN BWS.spr_id = 18
    THEN BWS.bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN BWS.spr_id = 22
    THEN BWS.bezugsweg_bez
    ELSE TRIM(SUBSTR(CAST(BWS.bezugsweg_id AS STRING), 1, 39))
    END)) AS bezugsweg_bez_bg
FROM kfl_production_dbp_view.v_l_bezugsweg AS BW
 INNER JOIN kfl_production_dbp_view.v_bezugsweg_spr_zu AS BWS ON BW.mandant_id = BWS.mandant_id AND BW.bezugsweg_id =
   BWS.bezugsweg_id
GROUP BY BW.bezugsweg_id;