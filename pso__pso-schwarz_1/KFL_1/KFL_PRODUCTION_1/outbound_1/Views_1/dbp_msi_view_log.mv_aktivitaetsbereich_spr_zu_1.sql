CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_aktivitaetsbereich_spr_zu_1 (mandant_id, aktivitaetsbereich_id,
aktivitaetsbereich_bez, aktivitaetsbereich_bez_de, aktivitaetsbereich_bez_cz, aktivitaetsbereich_bez_sk,
aktivitaetsbereich_bez_hr, aktivitaetsbereich_bez_pl, aktivitaetsbereich_bez_ro, aktivitaetsbereich_bez_bg) AS SELECT
 mandant_id,
 aktivitaetsbereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN aktivitaetsbereich_bez
   ELSE NULL
   END) AS aktivitaetsbereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN aktivitaetsbereich_bez
   ELSE NULL
   END) AS aktivitaetsbereich_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN aktivitaetsbereich_bez
    ELSE NULL
    END)) AS aktivitaetsbereich_bez_bg
FROM kfl_production_dbp_view.v_aktivitaetsbereich_spr_zu_1 AS V01
GROUP BY mandant_id,
 aktivitaetsbereich_id;