CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_USER_HR_OBJEKT_ID_ZU_2
(
mandant_id
, hr_objekt_ebene1_id
, user_id
)
AS
   SELECT
   mandant_id, hr_objekt_ebene1_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu_2;