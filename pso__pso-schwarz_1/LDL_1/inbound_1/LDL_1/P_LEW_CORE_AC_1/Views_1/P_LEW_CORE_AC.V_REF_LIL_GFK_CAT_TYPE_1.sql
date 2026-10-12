CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_LIL_GFK_CAT_TYPE_1
(
    gfk_cat_type_cd
    , gfk_cat_type_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       gfk_cat_type_cd,
   gfk_cat_type_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_lil_gfk_cat_type_1 ;