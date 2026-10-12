CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktionthema_spr_zu (aktion_thema_id, mandant_id, aktion_thema_bez
, aktion_thema_bez_de, aktion_thema_bez_cz, aktion_thema_bez_sk, aktion_thema_bez_hr, aktion_thema_bez_pl,
aktion_thema_bez_ro, aktion_thema_bez_bg) AS SELECT aktion_thema_id,
 mandant_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktion_thema_bez
    ELSE NULL
    END), 'nicht vorhanden') AS aktion_thema_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktion_thema_bez
    ELSE NULL
    END), 'nicht vorhanden') AS aktion_thema_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN aktion_thema_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_thema_bez
     ELSE NULL
     END), 'nicht vorhanden')) AS aktion_thema_bez_bg
FROM kfl_production_dbp_view.v_aktion_thema_spr_zu
WHERE mandant_id = 1
GROUP BY aktion_thema_id,
 mandant_id
UNION DISTINCT
SELECT 'nicht vorhanden' AS aktion_thema_id,
 1 AS mandant_id,
 'nicht vorhanden' AS aktion_thema_bez,
 'nicht vorhanden' AS aktion_thema_bez_de,
 'not available' AS aktion_thema_bez_cz,
 'not available' AS aktion_thema_bez_sk,
 'not available' AS aktion_thema_bez_hr,
 'not available' AS aktion_thema_bez_pl,
 'not available' AS aktion_thema_bez_ro,
 'not available' AS aktion_thema_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;