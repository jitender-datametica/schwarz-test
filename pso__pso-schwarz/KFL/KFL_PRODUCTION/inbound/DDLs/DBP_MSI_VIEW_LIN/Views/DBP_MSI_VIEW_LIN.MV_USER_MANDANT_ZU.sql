CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_USER_MANDANT_ZU
(
mandant_id
, user_id
)
AS
   SELECT
   mandant_id, user_id
   FROM dbp_security.user_hr_objekt_id_zu
   GROUP BY 1,2;