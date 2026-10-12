CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIAM_CLNT_CAT_LVL2_1
(
 liam_clnt_cat_id
 ,client_id
 ,liam_parnt_cat_desc
 ,liam_parnt_cat_desc_EN
 ,liam_short_parnt_cat_desc
 ,liam_short_parnt_cat_desc_EN
 ,liam_chld_cat_desc
 ,liam_chld_cat_desc_EN
 ,clnt_cat_lvl
) AS
SELECT
 liam_clnt_cat_id
 ,client_id
 ,liam_parnt_cat_desc
 ,liam_parnt_cat_desc_EN
 ,liam_short_parnt_cat_desc
 ,liam_short_parnt_cat_desc_EN
 ,liam_chld_cat_desc
 ,liam_chld_cat_desc_EN
 ,clnt_cat_lvl
FROM P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_LVL2_1 ;

