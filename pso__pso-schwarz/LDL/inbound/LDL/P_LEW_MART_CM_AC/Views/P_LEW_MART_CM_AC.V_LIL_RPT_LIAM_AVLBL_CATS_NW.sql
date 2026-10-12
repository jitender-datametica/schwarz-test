CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RPT_LIAM_AVLBL_CATS_NW
(
       client_id
       , liam_clnt_cat_id
       , liam_chld_cat_desc
       , liam_chld_cat_desc_EN
       , liam_clnt_parnt_cat_id
       , liam_parnt_cat_desc
       , liam_parnt_cat_desc_EN
       , prom_id
       , per_id
       , per_text
       , per_text_EN
       , valid_data_flg
       , valid_data_flg_cd
       , exp_delivered_nopromo
       , exp_delivered_promo
       , exp_total_uwg
       , exp_promo_uwg
       , bnc_prom_total
       , bnc_prom_brand_pl
       , exp_delivered_nopromo_uwg
       , exp_delivered_promo_uwg
       , exp_delivered
       , expected_uwg
       , data_expected
       , exp_delivered_uwg
       , delivered_uwg
) AS
SELECT
       client_id
       , liam_clnt_cat_id
       , liam_chld_cat_desc
       , liam_chld_cat_desc_EN
       , liam_clnt_parnt_cat_id
       , liam_parnt_cat_desc
       , liam_parnt_cat_desc_EN
       , prom_id
       , per_id
       , per_text
       , per_text_EN
       , valid_data_flg
       , valid_data_flg_cd
       , exp_delivered_nopromo
       , exp_delivered_promo
       , exp_total_uwg
       , exp_promo_uwg
       , bnc_prom_total
       , bnc_prom_brand_pl
       , exp_delivered_nopromo_uwg
       , exp_delivered_promo_uwg
       , exp_delivered
       , expected_uwg
       , data_expected
       , exp_delivered_uwg
       , delivered_uwg
FROM P_LEW_MART_CM.V_LIL_RPT_LIAM_AVLBL_CATS_NW ;

