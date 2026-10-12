CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_USER
(
user_id
)
AS

   SELECT v01.user_id

   FROM dbp_security.gruppe_user_zu v01

   GROUP BY v01.user_id;