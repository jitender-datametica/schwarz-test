CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_USER_MATRIX_1
(
gruppe_id
, user_id
)
AS

   SELECT v01.gruppe_id, 'User anlegen' user_id

   FROM dbp_security.gruppe_1 v01

   --Ausschluss der DUMMY_1-ID 0
   WHERE v01.gruppe_id <> 0

   UNION

   SELECT v02.gruppe_id, v02.user_id

   FROM dbp_security.gruppe_user_zu_1 v02

   --Ausschluss der DUMMY_1-ID 0
   WHERE v02.gruppe_id <> 0;