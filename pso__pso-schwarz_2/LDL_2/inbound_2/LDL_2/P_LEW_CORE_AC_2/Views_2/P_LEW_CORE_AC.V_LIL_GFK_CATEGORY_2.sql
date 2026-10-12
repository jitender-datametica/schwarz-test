CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_LIL_GFK_CATEGORY_2
(
    client_id
    , gfk_cat_sid
    , src_gfk_cat_cd
    , gfk_cat_name
    , gfk_cat_level
    , gfk_cat_type_cd
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   gfk_cat_sid,
   src_gfk_cat_cd,
   gfk_cat_name,
   gfk_cat_level,
   gfk_cat_type_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_lil_gfk_category_2 ;