CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artikeltyp_spr_zu_2 (mandant_id, artikeltyp_id,
artikeltyp_bez, artikeltyp_bez_de, artikeltyp_bez_cz, artikeltyp_bez_sk, artikeltyp_bez_hr, artikeltyp_bez_pl,
artikeltyp_bez_ro, artikeltyp_bez_bg) AS SELECT mandant_id,
 artikeltyp_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END), 'N/A') AS artikeltyp_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END), 'N/A') AS artikeltyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN artikeltyp_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN artikeltyp_bez
     ELSE NULL
     END), 'N/A')) AS artikeltyp_bez_bg
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_2 AS V01
GROUP BY mandant_id,
 artikeltyp_id;