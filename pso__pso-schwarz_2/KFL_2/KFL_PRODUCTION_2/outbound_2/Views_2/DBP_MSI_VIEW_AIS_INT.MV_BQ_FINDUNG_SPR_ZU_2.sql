CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_bq_findung_spr_zu_2 (mandant_id, bq_findung_id,
bq_findung_bez, bq_findung_bez_de, bq_findung_bez_cz, bq_findung_bez_sk, bq_findung_bez_hr, bq_findung_bez_pl,
bq_findung_bez_ro, bq_findung_bez_bg) AS SELECT mandant_id,
 bq_findung_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN bq_findung_bez
    ELSE NULL
    END), 'N/A') AS bq_findung_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN bq_findung_bez
    ELSE NULL
    END), 'N/A') AS bq_findung_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bq_findung_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN bq_findung_bez
     ELSE NULL
     END), 'N/A')) AS bq_findung_bez_bg
FROM kfl_production_dbp_view.v_bq_findung_spr_zu_2 AS V01
GROUP BY mandant_id,
 bq_findung_id;