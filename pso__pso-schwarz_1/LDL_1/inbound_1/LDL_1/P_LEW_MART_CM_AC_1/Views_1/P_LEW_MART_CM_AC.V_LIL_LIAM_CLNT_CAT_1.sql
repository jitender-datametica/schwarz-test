CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIAM_CLNT_CAT_1
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
) AS
SELECT
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
FROM P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_1 ;
