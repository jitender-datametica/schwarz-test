CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT SUBSTR(CAST(ASMP.assort_region_cat_id AS STRING), 1, 27) AS liam_clnt_cat_id,
 CAST(REG.region_id AS BIGNUMERIC) AS client_id,
 CAST(ASMP.assort_parnt_cat_name_de AS STRING) AS liam_parnt_cat_desc,
 CAST(ASMP.assort_parnt_cat_name_en AS STRING) AS liam_parnt_cat_desc_en,
 CAST(ASMP.assort_chld_cat_name_de AS STRING) AS liam_chld_cat_desc,
 CAST(ASMP.assort_chld_cat_name_en AS STRING) AS liam_chld_cat_desc_en,
 CAST(TRIM(ASMP.assort_chld_cat_name_de) AS STRING) AS liam_chld_cat_trim_desc,
 CAST(TRIM(ASMP.assort_chld_cat_name_en) AS STRING) AS liam_chld_cat_trim_desc_en,
 TRIM(CASE
   WHEN ASMC.assort_cat_level = 2
   THEN CAST(ASMP.assort_parnt_cat_name_de AS STRING)
   WHEN ASMC.assort_cat_level = 1
   THEN CAST(ASMP.assort_chld_cat_name_de AS STRING)
   ELSE TRIM(SUBSTR(TRIM(CAST(ASMP.assort_parnt_cat_name_de AS STRING)), 1, 7)) || ' / ' || TRIM(CAST(ASMP.assort_chld_cat_name_de AS STRING)
     )
   END) AS liam_cat_smart_desc,
 TRIM(CASE
   WHEN ASMC.assort_cat_level = 2
   THEN CAST(ASMP.assort_parnt_cat_name_en AS STRING)
   WHEN ASMC.assort_cat_level = 1
   THEN CAST(ASMP.assort_chld_cat_name_en AS STRING)
   ELSE TRIM(SUBSTR(TRIM(CAST(ASMP.assort_parnt_cat_name_en AS STRING)), 1, 7)) || ' / ' || TRIM(CAST(ASMP.assort_chld_cat_name_en AS STRING)
     )
   END) AS liam_cat_smart_desc_en,
 CAST(ASMC.assort_cat_level AS BIGNUMERIC) AS clnt_cat_lvl,
 ASMP.sel_srt_cd,
 COALESCE(ASMP.data_avbl_nopromo_fg, 0) AS bnc_prom_total,
  CASE
  WHEN COALESCE(ASMP.data_avbl_nopromo_fg, 0) = 1
  THEN 'J'
  ELSE 'N'
  END AS bnc_prom_total_decoded,
  CASE
  WHEN COALESCE(ASMP.data_avbl_nopromo_fg, 0) = 1
  THEN 'Y'
  ELSE 'N'
  END AS bnc_prom_total_decoded_en,
 COALESCE(ASMP.data_avbl_promo_fg, 0) AS bnc_prom_brand_pl,
  CASE
  WHEN COALESCE(ASMP.data_avbl_promo_fg, 0) = 1
  THEN 'J'
  ELSE 'N'
  END AS bnc_prom_brand_pl_decoded,
  CASE
  WHEN COALESCE(ASMP.data_avbl_promo_fg, 0) = 1
  THEN 'Y'
  ELSE 'N'
  END AS bnc_prom_brand_pl_decoded_en
FROM ldl_p_lew_process_mstr_ac.v_lil_assort_region_cat_2 AS ASMP
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON ASMP.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_assort_category_2 AS ASMC ON ASMP.assort_cat_sid = ASMC.assort_cat_sid;