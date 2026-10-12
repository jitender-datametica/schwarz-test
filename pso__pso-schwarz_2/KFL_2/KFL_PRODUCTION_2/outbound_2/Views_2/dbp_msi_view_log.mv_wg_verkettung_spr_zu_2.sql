CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_wg_verkettung_spr_zu_2 (mandant_id, wg_verkett_id,
wg_verkett_bez, wg_verkett_bez_de, wg_verkett_bez_cz, wg_verkett_bez_sk, wg_verkett_bez_hr, wg_verkett_bez_pl,
wg_verkett_bez_ro, wg_verkett_bez_bg) AS SELECT mandant_id,
 wg_verkett_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_verkett_bez
   ELSE NULL
   END) AS wg_verkett_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_verkett_bez
   ELSE NULL
   END) AS wg_verkett_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_verkett_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_verkett_bez
    ELSE NULL
    END)) AS wg_verkett_bez_bg
FROM kfl_production_dbp_view.v_wg_verkettung_spr_zu_2 AS V01
GROUP BY mandant_id,
 wg_verkett_id
UNION DISTINCT
SELECT mandant_id,
 -2 AS wg_verkett_id,
 'n/a' AS wg_verkett_bez,
 'n/a' AS wg_verkett_bez_de,
 'n/a' AS wg_verkett_bez_cz,
 'n/a' AS wg_verkett_bez_sk,
 'n/a' AS wg_verkett_bez_hr,
 'n/a' AS wg_verkett_bez_pl,
 'n/a' AS wg_verkett_bez_ro,
 'n/a' AS wg_verkett_bez_bg
FROM kfl_production_dbp_view.v_mandant_2 AS V02;