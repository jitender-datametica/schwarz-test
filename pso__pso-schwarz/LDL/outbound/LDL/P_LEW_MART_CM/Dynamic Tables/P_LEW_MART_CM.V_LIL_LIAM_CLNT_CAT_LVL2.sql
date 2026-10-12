CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_liam_clnt_cat_lvl2
 AS
SELECT liam_clnt_cat_id,
 client_id,
 liam_parnt_cat_desc,
 liam_parnt_cat_desc_en,
 CAST(TRIM(liam_parnt_cat_desc) AS STRING) AS liam_short_parnt_cat_desc,
 CAST(TRIM(liam_parnt_cat_desc_en) AS STRING) AS liam_short_parnt_cat_desc_en,
 liam_chld_cat_desc,
 liam_chld_cat_desc_en,
 clnt_cat_lvl
FROM ldl_p_lew_mart_cm.v_lil_liam_clnt_cat
WHERE clnt_cat_lvl = 2;

