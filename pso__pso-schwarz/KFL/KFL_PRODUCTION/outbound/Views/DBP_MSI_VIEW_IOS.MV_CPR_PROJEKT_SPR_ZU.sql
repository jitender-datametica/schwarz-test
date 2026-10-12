CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_projekt_spr_zu AS SELECT V02.projekt_id,
 V04.cpr_ext_id AS projekt_nr,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.cpr_projekt_bez
   ELSE NULL
   END) AS cpr_projekt_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN COALESCE(V02.cpr_projekt_langtext, '')
   ELSE NULL
   END) AS cpr_projekt_langtext,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_projekt_langtext, '')
    ELSE NULL
    END)) AS cpr_projekt_langtext_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
   ELSE NULL
   END) AS projekt_kbez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CAST(COALESCE(SUBSTR(V02.cpr_projekt_bez, 4, 80), '') AS STRING)
    ELSE NULL
    END)) AS projekt_kbez_bg,
 V04.mandant_id,
 V07.mandant_sort_id AS mandant_sort,
 V07.mandant_sort_id
FROM kfl_production_dbp_view.v_cpr_projekt_per AS V04
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per AS V02 ON V04.projekt_id = V02.projekt_id
 LEFT JOIN kfl_production_dbp_view.v_mandant AS V07 ON V04.mandant_id = V07.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per AS V03 ON V02.projekt_id = V03.projekt_id AND V02.spr_id =
   V03.spr_id
WHERE (V02.dat_bis IS NULL OR V02.dat_bis = DATE '9999-12-31')
 AND (V03.dat_bis IS NULL OR V03.dat_bis = DATE '9999-12-31')
 AND V04.dat_bis = DATE '9999-12-31'
GROUP BY V02.projekt_id,
 projekt_nr,
 V04.mandant_id,
 mandant_sort,
 V07.mandant_sort_id;