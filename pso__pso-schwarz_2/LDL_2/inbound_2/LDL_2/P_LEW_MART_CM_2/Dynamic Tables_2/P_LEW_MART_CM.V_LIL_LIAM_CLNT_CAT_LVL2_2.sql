
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_LIAM_CLNT_CAT_LVL2_2
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
 )
 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM AS
 SELECT
 liam_clnt_cat_id
 ,client_id
 ,liam_parnt_cat_desc
 ,liam_parnt_cat_desc_EN
 ,CAST(TRIM(liam_parnt_cat_desc) AS VARCHAR(128)) AS liam_short_parnt_cat_desc
 ,CAST(TRIM(liam_parnt_cat_desc_EN) AS VARCHAR(128)) AS liam_short_parnt_cat_desc_EN
 ,liam_chld_cat_desc
 ,liam_chld_cat_desc_EN
 ,clnt_cat_lvl
 FROM P_LEW_MART_CM.v_lil_liam_clnt_cat_2
  WHERE clnt_cat_lvl = 2;
