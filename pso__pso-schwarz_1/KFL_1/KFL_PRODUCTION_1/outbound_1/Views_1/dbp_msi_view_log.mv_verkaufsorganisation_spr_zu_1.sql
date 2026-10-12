CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_verkaufsorganisation_spr_zu_1 (mandant_id,
verkaufsorganisation_id, verkaufsorganisation_bez, verkaufsorganisation_bez_de, verkaufsorganisation_bez_cz,
verkaufsorganisation_bez_sk, verkaufsorganisation_bez_hr, verkaufsorganisation_bez_pl, verkaufsorganisation_bez_ro,
verkaufsorganisation_bez_bg) AS SELECT mandant_id,
 verkaufsorganisation_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN verkaufsorganisation_bez
   ELSE NULL
   END) AS verkaufsorganisation_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN verkaufsorganisation_bez
   ELSE NULL
   END) AS verkaufsorganisation_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN verkaufsorganisation_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verkaufsorganisation_bez
    ELSE NULL
    END)) AS verkaufsorganisation_bez_bg
FROM kfl_production_dbp_view.v_verkaufsorganisation_spr_zu_1 AS V01
GROUP BY mandant_id,
 verkaufsorganisation_id;