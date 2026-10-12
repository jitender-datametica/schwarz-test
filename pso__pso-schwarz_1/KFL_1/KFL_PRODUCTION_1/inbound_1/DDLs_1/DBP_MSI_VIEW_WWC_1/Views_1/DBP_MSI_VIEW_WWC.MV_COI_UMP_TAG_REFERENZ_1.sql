CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_TAG_REFERENZ_1
(
mandant_id,
gj_plan,
version_id,
land_level,
dat_plan,
dat_referenz,
faktor_kalender,
wert_kalender
)
AS
   SELECT
   mandant_id,
   gj_plan,
   version_id,
   land_level,
   dat_plan,
   dat_referenz,
   faktor_kalender,
   wert_kalender
   FROM dbp_view.v_coi_ump_tag_referenz_1;