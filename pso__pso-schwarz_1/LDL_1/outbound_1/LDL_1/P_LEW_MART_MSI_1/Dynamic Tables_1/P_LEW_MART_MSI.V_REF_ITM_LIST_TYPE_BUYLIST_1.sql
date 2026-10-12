CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_itm_list_type_buylist_1
OPTIONS(DESCRIPTION ='MULTISPRACHE ARTIKELARTEN REFERENZ, MULTISPRACHE ARTIKELARTEN REFERENZ', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
)
AS
SELECT buying_list_type_id,
 MAX(CASE
   WHEN language_id = 1
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN buying_list_type_desc
   ELSE NULL
   END) AS buying_list_type_desc_rs
FROM (SELECT buying_list_type_id,
    buying_list_type_desc,
    language_id
   FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1
   UNION ALL
   SELECT - 1 * buying_list_type_id AS def_buying_list_type_id,
     CASE
     WHEN buying_list_type_id = 2
     THEN 'EM ohne Listungsart'
     WHEN buying_list_type_id = 3
     THEN 'M ohne Listungsart'
     WHEN buying_list_type_id = 4
     THEN 'Aktionsartikel ohne Markenart'
     WHEN buying_list_type_id = 5
     THEN 'Normalsortiment ohne Markenart'
     ELSE NULL
     END AS buying_list_type_desc,
    language_id
   FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS R
   WHERE buying_list_type_id IN (2, 3, 4, 5)
    AND NOT EXISTS (SELECT 1
     FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS WAWI
     WHERE R.language_id = language_id
      AND - 1 * R.buying_list_type_id = buying_list_type_id)) AS d
GROUP BY buying_list_type_id;
