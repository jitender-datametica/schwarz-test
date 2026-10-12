CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_oug_id_spr_zu (mandant_id, oug_id, oug_id_bez,
oug_id_bez_de, oug_id_bez_cz, oug_id_bez_sk, oug_id_bez_hr, oug_id_bez_pl, oug_id_bez_ro, oug_id_bez_bg) AS SELECT
 mandant_id,
 oug_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN oug_id_bez
    ELSE NULL
    END), 'N/A') AS oug_id_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN oug_id_bez
    ELSE NULL
    END), 'N/A') AS oug_id_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN oug_id_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN oug_id_bez
     ELSE NULL
     END), 'N/A')) AS oug_id_bez_bg
FROM kfl_production_dbp_view.v_oug_id_spr_zu
WHERE mandant_id <> 1
GROUP BY mandant_id,
 oug_id
UNION ALL
SELECT DISTINCT mandant_id,
 0 AS oug_id,
 'nicht gepflegt' AS oug_id_bez,
 'nicht gepflegt' AS oug_id_bez_de,
 'žádné specifikace' AS oug_id_bez_cz,
 'žiadne špecifikácie' AS oug_id_bez_sk,
 'nema specifikacija' AS oug_id_bez_hr,
 'bez specyfikacji' AS oug_id_bez_pl,
 'fara precizare' AS oug_id_bez_ro,
 'без спецификация' AS oug_id_bez_bg
FROM kfl_production_dbp_view.v_mandant_spr_zu
WHERE mandant_id <> 1;