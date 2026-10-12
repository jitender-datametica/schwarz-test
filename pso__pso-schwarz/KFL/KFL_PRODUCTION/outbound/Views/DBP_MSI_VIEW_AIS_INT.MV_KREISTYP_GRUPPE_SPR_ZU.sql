CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_kreistyp_gruppe_spr_zu (mandant_id, kreistyp_gruppe_id,
kreistyp_gruppe_bez, kreistyp_gruppe_bez_de, kreistyp_gruppe_bez_cz, kreistyp_gruppe_bez_sk, kreistyp_gruppe_bez_hr,
kreistyp_gruppe_bez_pl, kreistyp_gruppe_bez_ro, kreistyp_gruppe_bez_bg) AS SELECT mandant_id,
 kreistyp_gruppe_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), 'N/A') AS kreistyp_gruppe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), 'N/A') AS kreistyp_gruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kreistyp_gruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kreistyp_gruppe_bez
     ELSE NULL
     END), 'N/A')) AS kreistyp_gruppe_bez_bg
FROM kfl_production_dbp_view.v_kreistyp_gruppe_spr_zu AS V01
GROUP BY mandant_id,
 kreistyp_gruppe_id;