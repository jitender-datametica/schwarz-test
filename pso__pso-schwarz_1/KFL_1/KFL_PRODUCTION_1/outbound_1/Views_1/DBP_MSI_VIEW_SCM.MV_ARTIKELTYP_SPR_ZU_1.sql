CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artikeltyp_spr_zu_1 AS SELECT mandant_id,
 artikeltyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN artikeltyp_bez
   ELSE NULL
   END) AS artikeltyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN artikeltyp_bez
   ELSE NULL
   END) AS artikeltyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez_bg
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_1
GROUP BY mandant_id,
 artikeltyp_id;