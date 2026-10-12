CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_HR_OBJEKT_ID_ZU
(
mandant_id
, hr_objekt_ebene1_id
, user_id
)
AS
   SELECT
   mandant_id, hr_objekt_ebene1_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu;