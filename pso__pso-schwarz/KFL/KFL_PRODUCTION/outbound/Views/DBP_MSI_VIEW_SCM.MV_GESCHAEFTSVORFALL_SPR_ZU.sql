CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_geschaeftsvorfall_spr_zu (mandant_id, geschaeftsvorfall_id,
geschaeftsvorfall_bez, geschaeftsvorfall_bez_de, geschaeftsvorfall_bez_cz, geschaeftsvorfall_bez_sk,
geschaeftsvorfall_bez_hr, geschaeftsvorfall_bez_pl, geschaeftsvorfall_bez_ro, geschaeftsvorfall_bez_bg) AS SELECT
 mandant_id,
 geschaeftsvorfall_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geschaeftsvorfall_bez
   ELSE NULL
   END) AS geschaeftsvorfall_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN geschaeftsvorfall_bez
   ELSE NULL
   END) AS geschaeftsvorfall_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN geschaeftsvorfall_bez
    ELSE NULL
    END)) AS geschaeftsvorfall_bez_bg
FROM kfl_production_dbp_view.v_geschaeftsvorfall_spr_zu AS V01
GROUP BY mandant_id,
 geschaeftsvorfall_id
UNION DISTINCT
SELECT mandant_id,
 '00' AS geschaeftsvorfall_id,
 'kein BBY' AS geschaeftsvorfall_bez,
 'non-BBY' AS geschaeftsvorfall_bez_de,
 'non-BBY' AS geschaeftsvorfall_bez_cz,
 'non-BBY' AS geschaeftsvorfall_bez_sk,
 'non-BBY' AS geschaeftsvorfall_bez_hr,
 'non-BBY' AS geschaeftsvorfall_bez_pl,
 'non-BBY' AS geschaeftsvorfall_bez_ro,
 'non-BBY' AS geschaeftsvorfall_bez_bg
FROM kfl_production_dbp_view.v_mandant AS V01
GROUP BY mandant_id;