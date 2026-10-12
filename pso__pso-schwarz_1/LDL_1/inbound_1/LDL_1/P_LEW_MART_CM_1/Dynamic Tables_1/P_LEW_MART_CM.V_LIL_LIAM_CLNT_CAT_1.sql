
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_1
 (
    liam_clnt_cat_id
  , client_id
  , liam_parnt_cat_desc
  , liam_parnt_cat_desc_EN
  , liam_chld_cat_desc
  , liam_chld_cat_desc_EN
  , liam_chld_cat_trim_desc
  , liam_chld_cat_trim_desc_EN
  , liam_cat_smart_desc
  , liam_cat_smart_desc_EN
  , clnt_cat_lvl
  , sel_srt_cd
  , bnc_prom_total
  , bnc_prom_total_decoded
  , bnc_prom_total_decoded_EN
  , bnc_prom_brand_pl
  , bnc_prom_brand_pl_decoded
  , bnc_prom_brand_pl_decoded_EN
 )
 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
 SELECT
    CAST(asmp.assort_region_cat_id AS CHAR(27)) AS liam_clnt_cat_id
  , CAST(reg.region_id AS SMALLINT) AS client_id
  , CAST(asmp.assort_parnt_cat_name_de AS VARCHAR(128)) AS liam_parnt_cat_desc
  , CAST(asmp.assort_parnt_cat_name_en AS VARCHAR(128)) AS liam_parnt_cat_desc_EN
  , CAST(asmp.assort_chld_cat_name_de AS VARCHAR(128)) AS liam_chld_cat_desc
  , CAST(asmp.assort_chld_cat_name_en AS VARCHAR(128)) AS liam_chld_cat_desc_EN
  , CAST(TRIM(asmp.assort_chld_cat_name_de) AS VARCHAR(128)) AS liam_chld_cat_trim_desc
  , CAST(TRIM(asmp.assort_chld_cat_name_en) AS VARCHAR(128)) AS liam_chld_cat_trim_desc_EN
  , CAST(TRIM(DECODE(asmc.assort_cat_level, 2, liam_parnt_cat_desc, 1, liam_chld_cat_desc, TRIM(SUBSTR(TRIM(liam_parnt_cat_desc), 1, 7))||' / ' ||TRIM(liam_chld_cat_desc))) AS VARCHAR(256)) AS liam_cat_smart_desc
  , CAST(TRIM(DECODE(asmc.assort_cat_level, 2, liam_parnt_cat_desc_EN, 1, liam_chld_cat_desc_EN, TRIM(SUBSTR(TRIM(liam_parnt_cat_desc_EN), 1, 7))||' / ' ||TRIM(liam_chld_cat_desc_EN))) AS VARCHAR(256)) AS liam_cat_smart_desc_EN
  , CAST(asmc.assort_cat_level AS SMALLINT) AS clnt_cat_lvl
  , asmp.sel_srt_cd
  , COALESCE(asmp.data_avbl_nopromo_fg, 0) AS bnc_prom_total
  , DECODE(COALESCE(asmp.data_avbl_nopromo_fg, 0), 1, 'J', 'N') AS bnc_prom_total_decoded
  , DECODE(COALESCE(asmp.data_avbl_nopromo_fg, 0), 1, 'Y', 'N') AS bnc_prom_total_decoded_EN
  , COALESCE(asmp.data_avbl_promo_fg, 0) AS bnc_prom_brand_pl
  , DECODE(COALESCE(asmp.data_avbl_promo_fg, 0), 1, 'J', 'N') AS bnc_prom_brand_pl_decoded
  , DECODE(COALESCE(asmp.data_avbl_promo_fg, 0), 1, 'Y', 'N') AS bnc_prom_brand_pl_decoded_EN
  FROM P_LEW_PROCESS_MSTR_AC.v_lil_assort_region_cat_1 AS asmp
  INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_1 AS reg
     ON reg.region_sid = asmp.region_sid
  INNER JOIN P_LEW_CORE_AC.v_lil_assort_category_1 AS asmc
     ON asmp.assort_cat_sid = asmc.assort_cat_sid;
