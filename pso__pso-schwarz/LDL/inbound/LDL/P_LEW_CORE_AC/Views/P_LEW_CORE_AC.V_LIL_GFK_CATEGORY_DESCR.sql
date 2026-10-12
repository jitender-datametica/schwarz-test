CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_LIL_GFK_CATEGORY_DESCR
(
  client_id
  , gfk_cat_sid
  , lang_cd
  , gfk_cat_name
  , dwh_load_id
  , dwh_created
  , dwh_updated
) AS
SELECT
  client_id
  , gfk_cat_sid
  , lang_cd
  , gfk_cat_name
  , dwh_load_id
  , dwh_created
  , dwh_updated
FROM P_LEW_CORE.T_LIL_GFK_CATEGORY_DESCR;
