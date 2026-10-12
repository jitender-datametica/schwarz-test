CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ZEITENTWICKLUNG_TAG_ZU_2
(
dat
,zeit_id
)
AS
   SELECT

   dat, kjmo AS zeit_id
   FROM dbp_view.v_tag_2

   UNION  ALL

   SELECT
   dat, gj  AS zeit_id
   FROM dbp_view.v_tag_2

   UNION ALL

   SELECT
   dat, kjwo * 10 As zeit_id
   FROM dbp_view.v_tag_2;