CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_posten_spr_zu_1 AS SELECT mandant_id,
 posten_id,
 MAX(CASE
   WHEN spr_id = 22 AND posten_id <> ''
   THEN posten_bez
   WHEN spr_id = 22 AND posten_id = ''
   THEN 'Sortimentsartikel'
   ELSE NULL
   END) AS posten_bez,
 MAX(CASE
   WHEN spr_id = 22 AND posten_id <> ''
   THEN posten_bez
   WHEN spr_id = 22 AND posten_id = ''
   THEN 'Sortimentsartikel'
   ELSE NULL
   END) AS posten_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 124 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 108 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 65 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 90 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 95 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 18 AND posten_id = ''
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_id <> ''
    THEN posten_bez
    WHEN spr_id = 22 AND posten_id = ''
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_bg
FROM kfl_production_dbp_view.v_artkz_posten_1
GROUP BY mandant_id,
 posten_id;