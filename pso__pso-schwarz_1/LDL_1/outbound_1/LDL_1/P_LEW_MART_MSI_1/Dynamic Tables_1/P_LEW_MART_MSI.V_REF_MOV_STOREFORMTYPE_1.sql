CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_mov_storeformtype_1
OPTIONS(DESCRIPTION = 'MULTI LANGUAGE REFERENCE FOR STOREFORM,MULTI LANGUAGE REFERENCE FOR STOREFORM', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
)
AS
SELECT STO.client_id,
 STO.sfo_type_id AS sfotype_id,
 MAX(CASE
   WHEN M.language_id = 1
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_at,
 MAX(CASE
   WHEN M.language_id = 2
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_be,
 MAX(CASE
   WHEN M.language_id = 12
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_be_fr,
 MAX(CASE
   WHEN M.language_id = 3
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_bg,
 MAX(CASE
   WHEN M.language_id = 4
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_ch,
 MAX(CASE
   WHEN M.language_id = 5
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_cy,
 MAX(CASE
   WHEN M.language_id = 6
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_cz,
 MAX(CASE
   WHEN M.language_id = 7
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc,
 MAX(CASE
   WHEN M.language_id = 8
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_dk,
 MAX(CASE
   WHEN M.language_id = 9
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_ee,
 MAX(CASE
   WHEN M.language_id = 10
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_es,
 MAX(CASE
   WHEN M.language_id = 11
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_fi,
 MAX(CASE
   WHEN M.language_id = 12
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_fr,
 MAX(CASE
   WHEN M.language_id = 13
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_gb,
 MAX(CASE
   WHEN M.language_id = 14
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_gr,
 MAX(CASE
   WHEN M.language_id = 15
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_hr,
 MAX(CASE
   WHEN M.language_id = 16
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_hu,
 MAX(CASE
   WHEN M.language_id = 17
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_ie,
 MAX(CASE
   WHEN M.language_id = 18
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_it,
 MAX(CASE
   WHEN M.language_id = 19
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_lt,
 MAX(CASE
   WHEN M.language_id = 20
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_lv,
 MAX(CASE
   WHEN M.language_id = 21
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_ni,
 MAX(CASE
   WHEN M.language_id = 22
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_nl,
 MAX(CASE
   WHEN M.language_id = 23
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_de,
 MAX(CASE
   WHEN M.language_id = 24
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_pl,
 MAX(CASE
   WHEN M.language_id = 25
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_pt,
 MAX(CASE
   WHEN M.language_id = 26
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_ro,
 MAX(CASE
   WHEN M.language_id = 27
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_se,
 MAX(CASE
   WHEN M.language_id = 28
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_si,
 MAX(CASE
   WHEN M.language_id = 29
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_sk,
 MAX(CASE
   WHEN M.language_id = 31
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_cs,
 MAX(CASE
   WHEN M.language_id = 32
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_mt,
 MAX(CASE
   WHEN M.language_id = 33
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_us,
 MAX(CASE
   WHEN M.language_id = 34
   THEN STO.sfo_type_descr
   ELSE NULL
   END) AS sfotype_desc_rs
FROM ldl_p_lew_core_ac.v_ref_store_form_type_descr_1 AS STO
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS L ON STO.lang_sid = L.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_1 AS M ON TRIM(M.sap_lang_cd) = TRIM(L.iso_cd)
GROUP BY STO.client_id,
 sfotype_id;
