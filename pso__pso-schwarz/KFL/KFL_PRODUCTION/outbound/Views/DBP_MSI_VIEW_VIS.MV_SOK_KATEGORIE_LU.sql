CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_kategorie_lu (mandant_id, sok_kategorie_id,
sok_fima_baustein_id, sok_kategorie_bez_de, sok_kategorie_bez, sok_kategorie_bez_cz, sok_kategorie_bez_sk,
sok_kategorie_bez_hr, sok_kategorie_bez_pl, sok_kategorie_bez_ro, sok_kategorie_bez_bg) AS SELECT KAT.mandant_id,
 KAT.sok_kategorie_id,
 KAT.sok_fima_baustein_id,
 MAX(CASE
   WHEN KATS.spr_id = 22
   THEN KATS.sok_kategorie_bez
   ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
   END) AS sok_kategorie_bez_de,
 MAX(CASE
   WHEN KATS.spr_id = 22
   THEN KATS.sok_kategorie_bez
   ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
   END) AS sok_kategorie_bez,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 124
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_kategorie_bez_cz,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 108
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_kategorie_bez_sk,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 65
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_kategorie_bez_hr,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 90
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_kategorie_bez_pl,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 95
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_kategorie_bez_ro,
 COALESCE(MAX(CASE
    WHEN KATS.spr_id = 18
    THEN KATS.sok_kategorie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN KATS.spr_id = 22
    THEN KATS.sok_kategorie_bez
    ELSE TRIM(SUBSTR(CAST(KATS.sok_kategorie_id AS STRING), 1, 39))
    END)) AS sok_platzierungswg_bez_bg
FROM kfl_production_dbp_view.v_l_sok_kategorie AS KAT
 INNER JOIN kfl_production_dbp_view.v_sok_kategorie_spr_zu AS KATS ON KAT.mandant_id = KATS.mandant_id AND KAT.sok_kategorie_id
    = KATS.sok_kategorie_id
GROUP BY KAT.mandant_id,
 KAT.sok_kategorie_id,
 KAT.sok_fima_baustein_id;