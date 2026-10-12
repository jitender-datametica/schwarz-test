CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_USER_1
(
user_id
)
AS

   SELECT v01.user_id

   FROM dbp_security.gruppe_user_zu_1 v01

   GROUP BY v01.user_id;