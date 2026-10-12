CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_lagerort_spr_zu_2 AS SELECT lagerort_id,
 mandant_id,
 nb_id,
 wup_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), 'N/A') AS lagerort_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), 'N/A') AS lagerort_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN CAST(wup_id AS STRING) || ' ' || lagerort_bez
     ELSE NULL
     END), 'N/A')) AS lagerort_bez_bg
FROM kfl_production_dbp_view.v_lagerort_spr_zu_2 AS V01
WHERE lagerort_id NOT IN ('-1', '-2', '-3')
GROUP BY lagerort_id,
 mandant_id,
 nb_id,
 wup_id;