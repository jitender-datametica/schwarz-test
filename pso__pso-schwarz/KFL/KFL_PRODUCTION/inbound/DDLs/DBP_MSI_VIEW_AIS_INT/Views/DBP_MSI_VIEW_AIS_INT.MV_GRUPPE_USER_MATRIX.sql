CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_USER_MATRIX
(
gruppe_id
, user_id
)
AS

   SELECT v01.gruppe_id, 'User anlegen' user_id

   FROM dbp_security.gruppe v01

   --Ausschluss der DUMMY-ID 0
   WHERE v01.gruppe_id <> 0

   UNION

   SELECT v02.gruppe_id, v02.user_id

   FROM dbp_security.gruppe_user_zu v02

   --Ausschluss der DUMMY-ID 0
   WHERE v02.gruppe_id <> 0;