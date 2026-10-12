CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_GFK_LIDL_CATEGORY_MATCH_2
(
      gfk_cat_name
    , subitemgroup_id
    , family_cd
    , gfk_cat_id
    , gfk_cat_type_cd
)
AS
SELECT
gfk_cat_name,
subitemgroup_id,
family_cd,
gfk_cat_id,
gfk_cat_type_cd
FROM p_lew_mart_cm.v_lil_gfk_lidl_category_match_2
;






