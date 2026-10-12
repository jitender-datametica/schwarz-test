CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_USER_MANDANT_ZU_2
(
mandant_id
, user_id
)
AS
   SELECT
   mandant_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu_2
   GROUP BY 1,2;