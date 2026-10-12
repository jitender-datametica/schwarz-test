CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_GFK_CAT_TYPE
(
      gfk_cat_type_id
    ,gfk_cat_type_name
    ,gfk_cat_type_name_EN
) AS
SELECT
      gfk_cat_type_id
    ,gfk_cat_type_name
    ,gfk_cat_type_name_EN
FROM P_LEW_MART_CM.V_LIL_GFK_CAT_TYPE ;

