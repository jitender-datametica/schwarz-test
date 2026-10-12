CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_posten_kz_sap_spr_zu_prompt_1 (posten_kz_sap, posten_bez_sap,
posten_bez_sap_de, posten_bez_sap_cz, posten_bez_sap_sk, posten_bez_sap_hr, posten_bez_sap_pl, posten_bez_sap_ro,
posten_bez_sap_bg) AS SELECT posten_kz_sap,
 MAX(CASE
   WHEN spr_id = 22 AND posten_kz_sap <>
     '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
   THEN 'Sortimentsartikel'
   ELSE NULL
   END) AS posten_bez_sap,
 MAX(CASE
   WHEN spr_id = 22 AND posten_kz_sap <>
     '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
   THEN 'Sortimentsartikel'
   ELSE NULL
   END) AS posten_bez_sap_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 124\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 108\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 65\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 90\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 95\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18 AND posten_kz_sap <>
      '\n            ) THEN posten_bez_sap\n            WHEN (\n               spr_id = 18\n               AND posten_kz_sap = '
      
    THEN ''
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22 AND posten_kz_sap <>
      '\n         ) THEN posten_bez_sap\n         WHEN (\n            spr_id = 22\n            AND posten_kz_sap = '
    THEN 'Sortimentsartikel'
    ELSE NULL
    END)) AS posten_bez_sap_bg
FROM kfl_production_dbp_view.v_posten_kz_sap_spr_zu_1
GROUP BY posten_kz_sap
UNION ALL
SELECT '' AS posten_kz_sap,
 'Sortiment' AS posten_bez_sap,
 'Sortiment' AS posten_bez_sap_de,
 'v\u00fdber' AS posten_bez_sap_cz,
 'v\u00fdber' AS posten_bez_sap_sk,
 'asortiman' AS posten_bez_sap_hr,
 'asortyment' AS posten_bez_sap_pl,
 'sortiment' AS posten_bez_sap_ro,
 'асортимент' AS posten_bez_sap_bg;